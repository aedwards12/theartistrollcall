require 'rails_helper'

RSpec.describe Video, type: :model do
  it "has a valid" do
    expect(build(:video)).to be_valid
  end
end
