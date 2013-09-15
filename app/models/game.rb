class Game < ActiveRecord::Base
  attr_accessible :giver_id, :change_major, :study_majors, :another_locations, 
    :locations, :bad_story, :good_story, :ugly_story, :completed_step_1,
    :completed_step_2, :completed_step_3, :good_keywords, :bad_keywords,
    :ugly_keywords, :good_anonymous, :bad_anonymous, :ugly_anonymous

  belongs_to :giver

  def complete_game(step)
    if step == 1
      self.completed_step_1 = true
    elsif step == 2
      self.completed_step_2 = true
    elsif step == 3
      self.completed_step_3 = true
    end
    self.save
  end

  def completed_3_games?
    self.completed_step_1 and self.completed_step_3 and self.completed_step_3
  end
end
