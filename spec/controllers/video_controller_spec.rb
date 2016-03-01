require 'rails_helper'

RSpec.describe VideoController, type: :controller do
  render_views
  describe "create" do
    it "create a valid video object" do
      params = {video: {url: "https://www.youtube.com/watch?v=ZYkmsFBcHxk" }, xhr: true}
      expect {
        VCR.use_cassette 'youtube_cassette' do
          post :create, params
        end
      }.to change(Video, :count).by(1)
      expect(Video.first.yt_author).to eq("Antoine Troupe")
    end
  end
end
