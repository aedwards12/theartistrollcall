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

  describe "#tag" do
    it "creates and artist_video" do
      vid = create(:video)
      params = {artist_role: "dancer(s)", dancer_tags: ["AnthonyEdwardsj"], commit: "Add Artist", video_id: vid.id,  xhr: true}
      VCR.use_cassette 'video_tag_cassette' do
        xhr :post, :tag, params
      end
      expect(Artist.where(twitter_screen_name: "AnthonyEdwardsj").exists?).to eq true
      art = Artist.where(twitter_screen_name: "AnthonyEdwardsj").first
      expect(Role.where(label: "dancer(s)").exists?).to eq true
      role = Role.where(label: "dancer(s)").first
      expect( ArtistVideo.where(artist: art.id, video_id: vid.id, role_id: role.id).exists?).to eq true
    end
  end
end
