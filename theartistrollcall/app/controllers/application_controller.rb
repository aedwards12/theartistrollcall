class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


private
  def twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV["CONSUMER_KEY"]
      config.consumer_secret =ENV["CONSUMER_SECRET"]
    end
  end

  # Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
  def prepare_access_token(oauth_token, oauth_token_secret)
      consumer = OAuth::Consumer.new( ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"], { :site => "https://api.twitter.com", :scheme => :header })

      # now create the access token object from passed values
      token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
      access_token = OAuth::AccessToken.from_hash(consumer, token_hash )

      return access_token
  end
end
