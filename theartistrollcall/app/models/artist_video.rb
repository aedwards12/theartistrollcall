class ArtistVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :artist

  enum artist_role: [ :dancer, :choreographer, :assist_choreographer ]

  def artist
    Artist.find(artist)
  end
end
