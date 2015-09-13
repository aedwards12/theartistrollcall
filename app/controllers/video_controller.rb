class VideoController < ApplicationController
  before_action :load_video, except: [:create, :index]
  before_action :set_twitter_client, only: [:tag]

  def tag
    dancer_list = params[:dancer_tags]
    @video.dancer_list.add(dancer_list, parse: true)
    if @video.save
        dancer_list.split(",").each do | dancer |
        if dancer.strip[0] == "@"
            user = @client.user(dancer.strip.downcase)
            @artist = Artist.where(
                                 twitter_id: user.id,
                                ).first_or_create do |art|
              art.twitter_screen_name = user.screen_name
              art.twitter_img_url = user.profile_image_url.to_s
              art.name = user.name
            end
           ArtistVideo.where(artist: @artist, video: @video).first_or_create do |art|
            art.artist_role =  params[:artist_role]
            art.save
           end
        end
      end
    end
    artists = @video.artists
    @choreographer = artists.where(id: @video.artist_videos.choreographer.pluck(:artist_id))
    @asst_choreographers =  artists.where(id: @video.artist_videos.asst_choreography.pluck(:artist_id))
    @dancers =  artists.where(id: @video.artist_videos.dancer.pluck(:artist_id))
  end

  def new
    new_video
  end

  def create
    @video = Video.where(url: video_params[:url].split('v=').second).first_or_create
    @new_video = Video.new
    if @video.save
      @video.set_yt_data
    end
  end

  def edit
    load_video
  end

  def index
    all_videos
    if params["q"]
      video_search = "%#{params["q"]}%"
      @videos_scope = @videos_scope.where("yt_title ILIKE ?", video_search)
    end
    @videos = @videos_scope
    # @videos = @videos_scope.extend(Kaminari::PaginatableRelationToPaginatableArray).to_paginatable_array
    respond_to do |format|
      format.html{}
      format.js{render '/video/index.js'}
    end
  end

  private

  def new_video
    @video = Video.new
  end

  def load_video
    @video = Video.find(params[:video_id] || params[:id])
    @video.set_yt_data
    artists = @video.artists
    @choreographer = artists.where(id: @video.artist_videos.choreographer.pluck(:artist_id))
    @asst_choreographers =  artists.where(id: @video.artist_videos.asst_choreography.pluck(:artist_id))
    @dancers =  artists.where(id: @video.artist_videos.dancer.pluck(:artist_id))
  end

  def all_videos
    @videos_scope = Video.all
  end

  def video_params
    params.require(:video).permit(:url, tag_list: [])
  end

  def set_twitter_client
    twitter_client
  end
end
