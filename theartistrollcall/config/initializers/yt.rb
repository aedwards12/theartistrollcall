Yt.configure do |config|
  config.log_level = :debug
  config.api_key = ENV["YT_PUBLIC_KEY"]
end