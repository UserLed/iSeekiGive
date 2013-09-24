class Message < ActiveRecord::Base
  attr_accessible :content, :from, :sender_id, :subject, :to, :recipient_id, :uid
  validates :subject, :presence => true
  validates :from,    :presence => true
  validates :to,      :presence => true

  belongs_to :sender,
             :class_name => 'User'
  belongs_to :recipient,
             :class_name => 'User'

  scope :receive_messages, ->(recipient_id){where(:recipient_id => recipient_id)}

  def self.inbox(current_user)
    msg_ids = self.select('MAX(id)').receive_messages(current_user.id).group(:sender_id)
    Message.where(:id =>msg_ids).order("updated_at DESC")
  end
end
