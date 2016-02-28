require 'rails_helper'

RSpec.describe VideoController, type: :controller do
  render_views
  describe "create" do
    it "create a valid video object" do
      params = {video: {url: "https://www.youtube.com/watch?v=ZYkmsFBcHxk" }, xhr: true}
      VCR.use_cassette 'youtube_cassette' do
        post :create, params
      end
    end
  end
end
