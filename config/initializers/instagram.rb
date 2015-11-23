Instagram.configure do |config|
  config.client_id         = ENV["INSTA_CONSUMER_KEY"]
  config.client_secret     = ENV["INSTA_CONSUMER_SECRET"]
  # config.access_token        = ENV["ACCESS_TOKEN"]
  # config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
end