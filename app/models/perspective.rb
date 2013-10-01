class Perspective < ActiveRecord::Base
  attr_accessible :anonymous, :giver_id, :story, :story_type

  belongs_to :giver
  has_many   :perspective_tags, :dependent => :destroy
end
