class ArtistVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :artist
  belongs_to :role

  scope :dancer, ->{where(artist_role: "0")}
  scope :choreography, ->{where(artist_role: "1")}
  scope :asst_choreography, ->{where(artist_role: "2")}

  ARTIST_ROLE = {
    dancer: 0,
    choreographer: 1,
    assist_choreographer: 2
  }

end
