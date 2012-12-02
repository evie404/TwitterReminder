class TweetCheckerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "tweet_check"
    
  def perform
    User.all.each do |user|
      user.update_tweets
    end

    self.class.perform_in(5.minutes)
  end
end