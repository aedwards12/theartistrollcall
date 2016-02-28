class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :dancers

  has_many :artist_videos
  has_many :artists, through: :artist_videos
  has_many :roles

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  validates :url, presence:{ format: YT_LINK_FORMAT,  message: 'Invalid youtube url'}, uniqueness: true

  def set_yt_data
    yt_url = YoutubeApi.new(url).youtube_search_url
    ApiRequest.cache(yt_url, YoutubeApi::CACHE_POLICY, id) do
      # do stuff here if needed
    end
  end
end
