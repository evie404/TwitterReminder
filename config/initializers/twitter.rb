Twitter.configure do |config|
  config.consumer_key = Setting.twitter_key
  config.consumer_secret = Setting.twitter_secret
  config.oauth_token = Setting.twitter_token
  config.oauth_token_secret = Setting.twitter_token_secret
end