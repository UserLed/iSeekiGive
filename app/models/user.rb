class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  attr_accessible :email, :first_name, :last_name, :country, :hear, :password, :password_confirmation, :authentications_attributes, :type
  attr_accessor :type_helper
  validates_uniqueness_of :email
  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  def activated?
    return false if self.activation_state == "pending"
  end

  def resend_activation_email!
    setup_activation
    send_activation_needed_email!
  end
end
