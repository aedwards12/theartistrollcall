class ArtistsController < ApplicationController
  before_action :set_twitter_client, only: [:show]


  def show
    load_artist
    @artist.set_twitter_data(@client)
    @artists = Artist.all.map{|x| {id: x.twitter_screen_name, text: "@#{x.twitter_screen_name}  (#{x.name})"}}
    set_meta_tag(:title, "Whodatisapp | #{@artist.twitter_screen_name}")
    set_meta_tag(:image, @artist.twitter_img_url.split('normal').join('200x200'))
  end

  private

  def load_artist
    @artist =  Artist.where(id: params[:id]).first
    @artist ||= Artist.where(twitter_screen_name: params[:id]).first
    @artist_videos = @artist.artist_videos.includes(:video)
    @videos = []
    @recommended_artists = []
    @artist_videos.each do  |a_v|
      a_v.video.set_yt_data
      @videos << a_v.video
      @recommended_artists << a_v.video.artists
    end
    @artist_videos = @artist_videos.select{|a| a.role != nil}.group_by{ |a| a.role.label.downcase }
    @recommended_artists = @recommended_artists.flatten - [@artist]
    @recommended_artists = @recommended_artists.uniq.shuffle.take(3).each{ |art| art.set_twitter_data(@client) }
  end

  def set_twitter_client
    twitter_client
  end
end
