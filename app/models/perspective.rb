class Perspective < ActiveRecord::Base
  attr_accessible :anonymous, :giver_id, :story, :story_type

  belongs_to :user
  has_many   :perspective_tags, :dependent => :destroy

  def name
    story.truncate(30, :ommisson => "...") if story.present?
  end
end
