class Artist < ActiveRecord::Base
  has_many :artist_videos
  has_many :videos, through: :artist_videos

   validates_uniqueness_of :twitter_id

   # delegate :artist_role, to: :artist_videos
end
