class Profile < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :artist
end
