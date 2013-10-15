class Location < ActiveRecord::Base
  attr_accessible :name, :user_id

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }

  belongs_to :user

  after_create :insert_into_tags

  def insert_into_tags
    self.user.tags.create(:name => self.name)
  end
end
