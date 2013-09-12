class Skill < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
  has_and_belongs_to_many :experiences
  has_and_belongs_to_many :educations
end
