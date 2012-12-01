class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :twitter_id, :created_at

  after_create :time_difference

  def self.previous_tweet(id,user_id)
    with_exclusive_scope{ where('id < ?',id).where('user_id = ?', user_id).order('id desc').first }
  end

  def previous_tweet
    Tweet.previous_tweet(id,user.id)
  end

  def time_difference
    logger.debug "get previous tweet"
    if previous_tweet
      self.previous_time_difference =  previous_tweet.created_at - self.created_at
      self.save
    end
  end
end
