class Message < ActiveRecord::Base
  attr_accessible :content, :from, :from_id, :subject, :to, :to_id, :uid
  validates :subject, :presence => true
  validates :from,    :presence => true
  validates :to,      :presence => true
end
