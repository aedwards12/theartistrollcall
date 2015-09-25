require 'json'
class WelcomeController < ApplicationController

  def index
    @videos = Video.all.limit(8)
    @videos.each(&:set_yt_data)
    @featured_artists = Artist.all.shuffle.take(4)
    @newest_videos = @videos.order(:created_at).reverse_order.limit(4)
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
