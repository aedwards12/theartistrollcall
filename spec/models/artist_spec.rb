require 'rails_helper'

RSpec.describe Artist, type: :model do
  it "has a valid model" do
    expect(build(:artist)).to be_valid
  end

  it "updates twitter image" do
    load_client
    artist = create(:artist, twitter_img_url: "false_image.jpg")
    VCR.use_cassette 'twitter_update_cassette' do
      artist.set_twitter_data(@client)
    end
    artist.reload
    expect(artist.twitter_img_url).to eq("http://pbs.twimg.com/profile_images/636694223107031040/OF7_RwIT_normal.jpg")
  end
end

def load_client
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["CONSUMER_KEY"]
    config.consumer_secret     = ENV["CONSUMER_SECRET"]
    config.access_token        = ENV["ACCESS_TOKEN"]
    config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  end
end