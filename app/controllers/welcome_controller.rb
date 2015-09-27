require 'json'
class WelcomeController < ApplicationController

  def index
    @newest_videos = Video.select("videos.*").joins(:artist_videos).group("videos.id").
    order("count(artist_videos.id) desc").
    limit(4)
    @newest_videos.each(&:set_yt_data)
    @featured_artists = Artist.all.shuffle.take(4)
  end

  def about
    @contact_form = ContactForm.new
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

    @artists = Artist.where('twitter_screen_name ILIKE ?', "%#{params["q"]}%" ).select(['id, twitter_screen_name As text'])
    respond_to do |format|
      format.json { render json: @artists}
    end
  end
end
