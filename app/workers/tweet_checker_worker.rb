class TweetCheckerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "tweet_check"
    
  def perform
    User.all.each do |user|
      if user.tweets.count == 0
        user.update_tweets(200)
      else
        user.update_tweets(50)
      end
    end

    self.class.perform_in(5.minutes)
  end
end