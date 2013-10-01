class Tag < ActiveRecord::Base
  attr_accessible :user_id, :name

  belongs_to :user
end
