class ArtistVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :artist

  scope :dancer, ->{where(artist_role: "0")}
  scope :choreography, ->{where(artist_role: "1")}
  scope :asst_choreography, ->{where(artist_role: "2")}


  enum artist_role: [ :dancer, :choreographer, :assist_choreographer ]

  def artist
    Artist.find(artist)
  end
end
