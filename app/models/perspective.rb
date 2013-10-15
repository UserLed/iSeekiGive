class Perspective < ActiveRecord::Base
  attr_accessible :anonymous, :user_id, :story, :story_type, :viewed, :saved

  belongs_to :user
  has_many   :perspective_tags, :dependent => :destroy

  def name
    story.truncate(30, :ommisson => "...") if story.present?
  end

  def view_counter
    self.viewed += 1
    self.save
  end

  def saved_counter
    self.saved += 1
    self.save
  end
end
