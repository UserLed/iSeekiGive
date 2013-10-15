class Language < ActiveRecord::Base
  attr_accessible :name, :user_id, :linkedin_id

  belongs_to :user

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }
  
end
