class VideoController < ApplicationController
  before_action :load_video, except: [:create]
  before_action :set_twitter_client, only: [:tag]

  def tag
    @twitter_list = []
    dancer_list = params[:dancer_tags]
    @video.dancer_list.add(dancer_list, parse: true)
    if @video.save
        dancer_list.split(",").each do | dancer |
        if dancer.strip[0] == "@"
            user = @client.user(dancer.strip.downcase.delete('@'))
           @twitter_list << user
            artist = Artist.create(
                                 twitter_screen_name: user.screen_name,
                                 twitter_img_url: user.profile_image_url.to_s,
                                 twitter_id: user.id,
                                 name: user.name
                                )
           ArtistVideo.create(artist: artist, video: @video, artist_role: params[:role] )
        end
      end
    end
    @twitter_list
  end

  def new
    new_video
  end

  def create
    @video = Video.new(url: video_params[:url].split('v=').second)
    if @video.save
      redirect_to root_path
    end
  end

  def edit
    load_video
  end

  private

  def new_video
    @video = Video.new
  end

  def load_video
    @video = Video.find(params[:video_id])
  end

  def all_videos
    @videos = Video.all
  end

  def video_params
    params.require(:video).permit(:url, tag_list: [])
  end

  def set_twitter_client
    twitter_client
  end
end
