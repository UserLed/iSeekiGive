class Tag < ActiveRecord::Base
  attr_accessible :user_id, :name

  belongs_to :user

  def self.record_exists?(name)
    self.where(:name => name).present?
  end
end
