class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :twitter_id, :created_at

  after_create :time_difference

  def self.previous_tweet(twitter_id,user_id)
    with_exclusive_scope{ where('twitter_id < ?',twitter_id).where('user_id = ?', user_id).order('twitter_id desc').first }
  end

  def previous_tweet
    Tweet.previous_tweet(twitter_id,user.id)
  end

  def time_difference
    logger.debug "get previous tweet"
    if previous_tweet
      self.previous_time_difference = self.created_at - previous_tweet.created_at 
      if self.previous_time_difference < 3600
        self.cummlative_time_difference = previous_tweet.cummlative_time_difference + self.previous_time_difference
      else
        self.cummlative_time_difference = 0
      end
      self.save
    end
  end
end
