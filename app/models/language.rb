class Language < ActiveRecord::Base
  attr_accessible :name, :user_id, :linkedin_id

  belongs_to :user

  validates :name, :presence => true, :uniqueness => { :scope => :user_id }


  after_create :insert_into_tags

  def insert_into_tags
    self.user.tags.create(:name => self.name)
  end
end
