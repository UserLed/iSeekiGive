class Keyword < ActiveRecord::Base
  serialize :story_keyword, Array	
  attr_accessible :game_id, :story_keyword
end
