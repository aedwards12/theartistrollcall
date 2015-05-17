require 'json'
class WelcomeController < ApplicationController
  def index
    @videos = Video.all
    @videos.each(&:set_yt_data)
  end

  def search
    # Exchange our oauth_token and oauth_token secret for the AccessToken instance.
    # access_token = prepare_access_token(ENV["ACCESS_TOKEN"], ENV["ACCESS_TOKEN_SECRET"])

    # # use the access token as an agent to get the home timeline
    # response = access_token.request(:get, "https://api.twitter.com/1.1/users/search.json?q=#{params["q"]}&count=5")
    # data = JSON.parse(response.body)
    # data_array = []
    # data.count.times do |x|
    #   data_array << {"id"=> x, "text"=> data[x]["screen_name"]}
    # end
    # respond_to do |format|
    #   format.json { render json: data_array }
    # end
    # binding.pry

    @artists = Artist.where('twitter_screen_name ILIKE ?', "%#{params["q"]}%" ).select(['id, twitter_screen_name As text'])
    respond_to do |format|
      format.json { render json: @artists}
    end
  end

  def twitter_callback_url
    # binding.pry
  end
end
