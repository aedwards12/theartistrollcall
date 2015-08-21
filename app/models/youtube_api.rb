class YoutubeApi
  attr_accessor  :url

  BASE_URL = "https://www.youtube.com/watch?v="
  CACHE_POLICY = lambda { 6.hours.ago }

  def initialize(url)
    @url = url
  end

  def youtube_search_url
    BASE_URL + "#{url}"
  end
end