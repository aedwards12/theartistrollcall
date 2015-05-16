class ArtistsController < ApplicationController

  def show
    load_artist
  end

  def load_artist
    @artist =  Artist.find(params[:id])
    @videos = @artist.videos
    @recommended_artists = []
    @videos.each do |vid|
      @recommended_artists << vid.artists
    end
     @recommended_artists = @recommended_artists.flatten - [@artist]
  end
end
