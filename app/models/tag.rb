class Tag < ActiveRecord::Base
  attr_accessible :user_id, :name, :linkedin_id, :linkedin_data_type

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }

  belongs_to :user
end
