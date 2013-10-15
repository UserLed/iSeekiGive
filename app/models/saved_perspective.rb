class SavedPerspective < ActiveRecord::Base
  attr_accessible :perspective_id, :user_id

  validates :perspective_id, :presence => true, :uniqueness => { :scope => :user_id }
end
