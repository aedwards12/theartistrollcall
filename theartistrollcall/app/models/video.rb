class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :dancers

  has_many :artist_videos
  has_many :artists, through: :artist_videos

end
