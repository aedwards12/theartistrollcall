class VideoController < ApplicationController
  before_action :set_twitter_client, only: [:tag, :show]
  before_action :load_video, except: [:create, :index]

  def tag
    dancer_list = params[:dancer_tags].first.split(",")
    @video.dancer_list.add(dancer_list, parse: true)
    dancer_list.each do | dancer |
      @artist = Artist.where(twitter_screen_name: dancer).first
      begin
        @artist ||=@client.user(dancer.strip.downcase)
        if @artist.class.name != "Artist"
          @artist = Artist.where(
                               twitter_id: @artist.id,
                              ).first_or_create do |art|
            art.twitter_screen_name = @artist.screen_name
            art.twitter_img_url = @artist.profile_image_url.to_s
            art.name = @artist.name
          end
        end
        ArtistVideo.where(artist: @artist, video: @video, artist_role: ArtistVideo::ARTIST_ROLE[ params[:artist_role].to_sym]).first_or_create

      rescue Twitter::Error

      end
    end
    artists = @video.artists
    @choreographer = artists.where(id: @video.artist_videos.choreographer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
    @asst_choreographers = artists.where(id: @video.artist_videos.asst_choreography.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
    @dancers = artists.where(id: @video.artist_videos.dancer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
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

  def show
    set_meta_tag(:title, "Whodatisapp | #{@video.yt_title}")
    set_meta_tag(:image, "http://img.youtube.com/vi/#{@video.url}/mqdefault.jpg")
    set_meta_tag(:card, "summary_large_image")
    # set_meta_tag(
    #   :image, {
    #     _:      "http://img.youtube.com/vi/#{@video.url}/mqdefault.jpg",
    #     width:  100,
    #     height: 100,
    #   }
    # )
    @artists = Artist.all.map{|x| {id: x.twitter_screen_name, text: "@#{x.twitter_screen_name}  (#{x.name})"}}
  end

  def index
    set_meta_tag(:title, "Whodatisapp | Videos Collection")
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

  def artists
    set_meta_tag(:title, "Whodatisapp | View All Artists | #{@video.yt_title}")
    set_meta_tag(:image, "http://img.youtube.com/vi/#{@video.url}/mqdefault.jpg")
  end

  private

  def new_video
    @video = Video.new
  end

  def load_video
    @video = Video.find(params[:video_id] || params[:id])
    @video.set_yt_data
    artists = @video.artists
    @choreographer = artists.where(id: @video.artist_videos.choreographer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }.uniq
    @asst_choreographers =  artists.where(id: @video.artist_videos.asst_choreography.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }.uniq
    @dancers =  artists.where(id: @video.artist_videos.dancer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }.uniq
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
