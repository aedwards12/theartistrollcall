class ApiRequest < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy, id)
    find_or_initialize_by(url: url).cache(cache_policy, url, id) do
      if block_given?
        yield
      end
    end
  end

  def cache(cache_policy, url, id)
    if new_record? || updated_at < cache_policy.call
      vid = Video.find id
      yt_video = Yt::Video.new url: url
      vid.yt_count = yt_video.view_count
      vid.yt_title = yt_video.title
      vid.yt_description = yt_video.description
      vid.yt_author = yt_video.snippet.data['channelTitle']
      vid.yt_pub_date = yt_video.snippet.data["publishedAt"]
      vid.save!
      update_attributes(updated_at: Time.zone.now)
      yield
    end
  end
end
