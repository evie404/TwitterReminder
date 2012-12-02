class TweetCheckerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "tweet_check"
    
  def perform
    # snippet = Snippet.find(snippet_id)
    # uri = URI.parse("http://pygments.appspot.com/")
    # request = Net::HTTP.post_form(uri, lang: snippet.language, code: snippet.plain_code)
    # snippet.update_attribute(:highlighted_code, request.body)

    User.all.each do |user|
      user.update_tweets(50)
    end

    #self.perform_in(5.minutes)
  end
end