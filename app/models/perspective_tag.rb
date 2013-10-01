class PerspectiveTag < ActiveRecord::Base
  attr_accessible :perspective_id, :name

  belongs_to :perspective
end
