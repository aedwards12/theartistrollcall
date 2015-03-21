class VideoController < ApplicationController
  before_action :load_video, except: [:create]

  def tag
    dancer_list = params[:dancer_tags]
    @video.dancer_list.add(dancer_list, parse: true)
    @video.save
    redirect_to :back
  end

  def new
    new_video
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to root_path
    end

  end

  def edit
    load_video
  end

  def search

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
end
