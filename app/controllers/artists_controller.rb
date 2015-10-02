class ArtistsController < ApplicationController

  def show
    load_artist
  end

  def load_artist
    @artist =  Artist.find(params[:id])
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
