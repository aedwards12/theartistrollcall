class VideoController < ApplicationController
  before_action :load_video, except: [:create, :index]
  before_action :set_twitter_client, only: [:tag]

  def tag
    dancer_list = params[:dancer_tags]
    @video.dancer_list.add(dancer_list, parse: true)
    if @video.save
        dancer_list.split(",").each do | dancer |
        if dancer.strip[0] == "@"
            user = @client.user(dancer.strip.downcase.delete('@'))
            @artist = Artist.where(
                                 twitter_screen_name: user.screen_name,
                                 twitter_img_url: user.profile_image_url.to_s,
                                 twitter_id: user.id,
                                 name: user.name
                                ).first_or_create
           ArtistVideo.where(artist: @artist, video: @video, artist_role: params[:artist_role] ).first_or_create

        end
      end
    end

    choreographer = ArtistVideo.where(video_id: @video.id, artist_role: '1').first
    if choreographer
      @choreographer = Artist.find(choreographer.artist_id)
    end
    dancers = ArtistVideo.where(video_id: @video.id, artist_role: '0')
    @dancers = Artist.find(dancers.pluck(:artist_id))
    respond_to do |format|
      format.js {render 'tag'}
    end
  end

  def new
    new_video
  end

  def create
    @video = Video.new(url: video_params[:url].split('v=').second)
    @new_video = Video.new

    if @video.save
      redirect_to video_path(@video)
    end
  end

  def edit
    load_video
  end

  def index
    all_videos
    @videos.each(&:set_yt_data)
  end

  private

  def new_video
    @video = Video.new
  end

  def load_video
    @video = Video.find(params[:video_id] || params[:id])
    @video.set_yt_data
    choreographer = ArtistVideo.where(video_id: @video.id, artist_role: '1').first
    if choreographer
      @choreographer = Artist.find(choreographer.artist_id)
    end
    dancers = ArtistVideo.where(video_id: @video.id, artist_role: '0')
    @dancers = Artist.find(dancers.pluck(:artist_id))
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
