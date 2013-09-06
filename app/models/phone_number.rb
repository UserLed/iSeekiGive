class PhoneNumber < ActiveRecord::Base
  attr_accessible :number, :pin, :user_id, :verified

  belongs_to :user

  validates :number, :presence => true
  
end
