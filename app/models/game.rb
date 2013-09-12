class Game < ActiveRecord::Base
  attr_accessible :giver_id, :change_major, :study_majors, :another_locations, 
    :locations, :bad_story, :good_story, :ugly_story

  belongs_to :giver
end
