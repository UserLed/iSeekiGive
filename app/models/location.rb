class Location < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }
end
