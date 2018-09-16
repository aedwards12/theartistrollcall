class VideoController < ApplicationController
  before_action :set_twitter_client, only: [:tag, :show]
  before_action :load_video, except: [:create, :index]

  def tag
    dancer_list = params[:dancer_tags].first.split(",")
    @video.dancer_list.add(dancer_list, parse: true)
    dancer_list.each do | dancer |
      if params[:handle_type][0] == 'twitter'
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
          else
            twitter_profile = @client.user(dancer.strip.downcase)
            @artist.twitter_screen_name = twitter_profile.screen_name
            @artist.twitter_img_url = twitter_profile.profile_image_url.to_s
            @artist.save
          end


          @role = Role.where(label: params[:artist_role]).first_or_create
          ArtistVideo.where(artist: @artist, video: @video, role: @role).first_or_create
        rescue Twitter::Error

        end
        artists = @video.artists
        @choreographer = artists.where(id: @video.artist_videos.choreographer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
        @asst_choreographers = artists.where(id: @video.artist_videos.asst_choreography.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
        @dancers = artists.where(id: @video.artist_videos.dancer.pluck(:artist_id)).each{ |art| art.set_twitter_data(@client) }
      elsif params[:handle_type][0] == 'facebook'
        browser = Watir::Browser.start "https://www.facebook.com/danielle.jo1"
        browser.text_field(name: 'email').set("anthony.edwardsjr@gmail.com")
        browser.text_field(name: 'pass').set("Bail3four@22")
        browser.button(value: 'Log In').click
        sleep 0.1
        html = browser.html
        noko_html = Nokogiri::HTML(html)
        href = noko_html.css('.photoContainer')[0].children[0].children[0].attributes["href"].value
        browser.close
        id = href.split('.').last.split('&').first
        response = open("https://graph.facebook.com/#{id}?access_token=#{fb_provider.token}&fields=id,name,picture").read
      end
    end
  end

  def new
    new_video
  end

  def create
    @video = Video.where(url: video_params[:url].split('v=').second).first_or_create
    @new_video = Video.new
    if @video.save
      @video.set_yt_data
      render :js => "window.location.href = '#{video_path(@video)}'"
    end
  end

  def edit
    load_video
  end

  def show
    set_meta_tag(:title, "Whodatisapp | #{@video.yt_title}")
    set_meta_tag(:image, "http://img.youtube.com/vi/#{@video.url}/mqdefault.jpg")
    set_meta_tag(:card, "summary_large_image")
    set_meta_tag(:site, "@AnthonyEdwardsj")
    @artist_vid_labels = @artist_videos.map{ |key, v| {id: key.downcase, text: key.capitalize}} | Role:: DEFAULT_LABELS
    @artists = Artist.all.map{|x| {id: x.twitter_screen_name, text: "@#{x.twitter_screen_name}  (#{x.name})"}}
    @handles = Artist::HANDLES
    twitter_text
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
    twitter_text
  end

  private

  def fb_provider
    current_user.identities.where(provider: 'facebook').first
  end

  def new_video
    @video = Video.new
  end

  def load_video
    @video = Video.find(params[:video_id] || params[:id])
    @video.set_yt_data
    @_artists = []
    @artist_videos = @video.artist_videos.includes(:artist)
    @artist_videos.each do  |a_v|
      a_v.artist.set_twitter_data(@client) if a_v.artist
      @_artists << a_v.artist
    end
    @artist_videos = @artist_videos.select{|a| a.role != nil}.group_by{ |a| a.role.label.downcase }
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

  def twitter_text
    remaining_a_v = @artist_videos.except([ "Choreographer(s)", "Asst Choreographer(s)", "dancer(s)"])
    twitter_text =  "Checkout the work of #{ (@artist_videos["Choreographer(s)"] | @artist_videos["Asst Choreographer(s)"]).map{|d| "@" + d.artist.twitter_screen_name}.join(', ')  if @artist_videos["Choreographer(s)"] || @artist_videos["Asst Choreographer(s)"]} ft. #{@artist_videos["dancer(s)"].
      map{|d| "@" + d.artist.twitter_screen_name}.join(', ') if @artist_videos["dancer(s)"]} #{remaining_a_v.values.flatten.map{|d| "@" + d.artist.twitter_screen_name}.join(', ')}"
    @twitter_encoded_string = ERB::Util.url_encode(twitter_text)
  end
end
