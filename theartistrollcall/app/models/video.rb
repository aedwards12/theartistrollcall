class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :dancers

  has_many :artist_videos
  has_many :artists, through: :artist_videos

  attr_accessor :yt_count, :yt_title, :yt_description, :yt_author, :yt_pub_date


  def set_yt_data
    logger.ap url
    yt_video = Yt::Video.new url: "https://www.youtube.com/watch?v=#{url}"
    self.yt_count = yt_video.view_count
    self.yt_title = yt_video.title
    self.yt_description = yt_video.description
    self.yt_author = yt_video.snippet.data['channelTitle']
    self.yt_pub_date = yt_video.snippet.data["publishedAt"]
  end

end
