class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :dancers

  has_many :artist_videos
  has_many :artists, through: :artist_videos

  YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

  validates :url, presence:{ format: YT_LINK_FORMAT,  message: 'Invalid youtube url'}, uniqueness: true


  attr_accessor :yt_count, :yt_title, :yt_description, :yt_author, :yt_pub_date


  def set_yt_data
    yt_video = Yt::Video.new url: "https://www.youtube.com/watch?v=#{url}"
    self.yt_count = yt_video.view_count
    self.yt_title = yt_video.title
    self.yt_description = yt_video.description
    self.yt_author = yt_video.snippet.data['channelTitle']
    self.yt_pub_date = yt_video.snippet.data["publishedAt"]
    rescue Yt::Error => e
    self.yt_count =  "no data available"
    self.yt_title =  "no data available"
    self.yt_description =  "no data available"
    self.yt_author =  "no data available"
    self.yt_pub_date =  "no data available"
  end

end
