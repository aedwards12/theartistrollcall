require 'rails_helper'

RSpec.describe ArtistVideo, type: :model do
 it "has a valid model" do
    expect(build(:artist_video)).to be_valid
  end
end
