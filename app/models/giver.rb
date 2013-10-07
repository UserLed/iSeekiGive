class Giver < User
  # has_one  :game,         :dependent => :destroy
  # has_many :time_slots,   :dependent => :destroy
  # has_many :schedules,    :dependent => :destroy
  # has_many :perspectives, :dependent => :destroy

  # def good_perspective
  #   if @good_perspective.blank?
  #     perspective = self.perspectives.find_by_story_type("The Good")
  #     @good_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Good")
  #   end
  #   @good_perspective
  # end

  # def bad_perspective
  #   if @bad_perspective.blank?
  #     perspective = self.perspectives.find_by_story_type("The Bad")
  #     @bad_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Bad")
  #   end
  #   @bad_perspective
  # end

  # def ugly_perspective
  #   if @ugly_perspective.blank?
  #     perspective = self.perspectives.find_by_story_type("The Ugly")
  #     @ugly_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Ugly")
  #   end
  #   @ugly_perspective
  # end
  
end