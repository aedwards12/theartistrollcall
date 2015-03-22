class WelcomeController < ApplicationController
  def index
    @video = Video.all.sample
    @new_video = Video.new
    twitter_client
   @twitter = @client.user("anthonyedwardsj")

   binding.pry
  end

  def search

  end


end
