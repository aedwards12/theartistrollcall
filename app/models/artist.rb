class Artist < ActiveRecord::Base
  acts_as_votable
  has_many :artist_videos
  has_many :videos, through: :artist_videos
  has_many :profiles

  validates_uniqueness_of :twitter_id

  def type
    self.class.name
  end

  def set_twitter_data(client)
    twitter_url = TwitterApi.new(twitter_id).twitter_search_url

    ApiRequest.cache(twitter_url, TwitterApi::CACHE_POLICY, id,'Twitter', client) do
      # do stuff here if needed
    end
  end

  def has_facebook_profile?
    Facebook.where(artist: self).exists
  end

  def facebook_profile
    profiles.where(type: 'facebook').first
  end
end
