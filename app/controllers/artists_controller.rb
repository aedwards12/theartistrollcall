class ArtistsController < ApplicationController
  before_action :set_twitter_client, only: [:show]


  def show
    load_artist
    @artist.set_twitter_data(@client)
    set_meta_tag(:title, "Whodatisapp | #{@artist.twitter_screen_name}")
    set_meta_tag(:image, @artist.twitter_img_url.split('normal').join('200x200'))
  end

  private

  def load_artist
    @artist =  Artist.where(id: params[:id]).first
    @artist ||= Artist.where(twitter_screen_name: params[:id]).first
    @videos = @artist.videos

    @dancer_videos = @artist.videos.merge(ArtistVideo.dancer)
    @choreography_videos = @artist.videos.merge(ArtistVideo.choreography)
    @asst_choreography = @artist.videos.merge(ArtistVideo.asst_choreography)
    @recommended_artists = []
    @videos.each do |vid|
      @recommended_artists << vid.artists
    end
    @recommended_artists = @recommended_artists.flatten - [@artist]
    @recommended_artists = @recommended_artists.uniq.shuffle.take(3).each{ |art| art.set_twitter_data(@client) }
  end

  def set_twitter_client
    twitter_client
  end
end
