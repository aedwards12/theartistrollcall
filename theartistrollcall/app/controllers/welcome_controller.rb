class WelcomeController < ApplicationController
  def index
    @video = Video.all.sample
    @twitter_list = []
    @new_video = Video.new
     twitter_client
    if @video.dancer_list.size>=1
      @video.dancer_list.to_a.each do | dancer |
        if dancer[0] == "@"
           @twitter_list << @client.user(dancer.delete('@'))
        end
      end
     end
  end

  def search

  end
end
