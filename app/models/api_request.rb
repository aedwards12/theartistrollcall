class ApiRequest < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy, id, type = nil, client = nil)
    find_or_initialize_by(url: url).cache(cache_policy, url, id, type, client) do
      if block_given?
        yield
      end
    end
  end

  def cache(cache_policy, url, id, type, client)
    if new_record? || updated_at < cache_policy.call
      if type == 'Twitter'
        artist = Artist.find id
        begin
          tw_node = client.user(artist.twitter_screen_name)
          artist.twitter_img_url = tw_node.profile_image_url.to_s
          artist.save
        rescue Twitter::Error
        end
      else
        vid = Video.find id
        yt_video = Yt::Video.new url: url
        vid.yt_count = yt_video.view_count
        vid.yt_title = yt_video.title
        vid.yt_description = yt_video.description
        vid.yt_author = yt_video.snippet.data['channelTitle']
        vid.yt_pub_date = yt_video.snippet.data["publishedAt"]
        vid.save!
      end
      update_attributes(updated_at: Time.zone.now)
      yield
    end
  end
end
