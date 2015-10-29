class TwitterApi
  attr_accessor  :twitter_id

  BASE_URL = "https://api.twitter.com/1.1/users/lookup.json?screen_name="
  CACHE_POLICY = lambda { 6.hours.ago }

  def initialize(twitter_id)
    @twitter_id = twitter_id
  end

  def twitter_search_url
    BASE_URL + "#{twitter_id}"
  end
end