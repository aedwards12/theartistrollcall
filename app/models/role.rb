class Role < ActiveRecord::Base
  belongs_to :video

  DEFAULT_LABELS = ["Choreographer(s)", "Asst Choreographer(s)", "Dancer(s)", "Videographer", "Artistic Director", "Producer"].map{|key| {id: key.downcase, text: key.capitalize} }
end
