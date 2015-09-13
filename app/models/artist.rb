class Artist < ActiveRecord::Base
  acts_as_votable
  has_many :artist_videos
  has_many :videos, through: :artist_videos

  validates_uniqueness_of :twitter_id

  def type
    self.class.name
  end
end
