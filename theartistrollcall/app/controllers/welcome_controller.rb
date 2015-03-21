class WelcomeController < ApplicationController
  def index
    @video = Video.all.sample
    @new_video = Video.new
  end

  def search

  end


end
