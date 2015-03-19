class Video < ActiveRecord::Base
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :dancers

  def new
    new_video
  end

  def create

  end

  def edit
    load_video(params[:id])
  end

  def search
  end


  private

  def new_video
    @video = Video.new
  end

  def load_video(id)
    @video = Video.find(id)
  end

  def all_video
    @videos = Video.all
  end
end
