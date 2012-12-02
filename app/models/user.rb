class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable, :database_authenticatable#, :registerable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid, :username
  # after_create :update_tweets
  # attr_accessible :title, :body

  has_many :tweets

  def update_tweets(limit = 200)
    require 'open-uri'
    require 'json'

    if self.last_tweet_id
      url = "https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=#{self.username}&count=#{limit}&since_id=#{self.last_tweet_id}"
    else
      url = "https://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=#{self.username}&count=200"
    end
    
    @results = JSON.parse(open(url).read).reverse

    @last_tweet

    @results.each do |result|
      @last_tweet = self.tweets.where({created_at: Time.parse(result['created_at']), twitter_id: result['id']}).first_or_create
    end

    #@results.last['']
    if @last_tweet
      self.last_tweet_id = @last_tweet.twitter_id
      self.save
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.email  = nil if !auth.email && !auth.email_address
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
