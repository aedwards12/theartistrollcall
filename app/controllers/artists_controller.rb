class ArtistsController < ApplicationController

  def show
    load_artist
    set_meta_tag(:title, "Whodatisapp | #{@artist.twitter_screen_name}")
    set_meta_tag(:image, @artist.twitter_img_url.split('normal').join('200x200'))
  end

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
    @recommended_artists = @recommended_artists.shuffle.take(3)
  end
end
