class User < ActiveRecord::Base
#  include ActionView::Helpers::TextHelper
  
  authenticates_with_sorcery!
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  attr_accessible :email, :first_name, :last_name, :country, :hear, :password,
    :password_confirmation, :authentications_attributes, :type, :promotional_news,
    :city
  
  attr_accessor :type_helper, :password_confirmation

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates_uniqueness_of :email
  validates :country, :presence => true
  validates_length_of :password, :minimum => 3, :if => :password
  validates_confirmation_of :password, :if => :password
  
  has_many :authentications, :dependent => :destroy
  has_many :educations
  has_many :skills
  has_many :experiences
  
  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :experiences
  
  HOW_HEAR = [
    ["By Friend"],
    ["Internet Search"],
    ["Advertisement"],
    ["Others"]
  ]

  def name
    "#{first_name} #{last_name}"
  end

  def provider
    if self.external?
      self.authentications.present? ? self.authentications.first.provider : "deleted"
    end
  end

  def activated?
    self.activation_state == "pending" ? false : true
  end

  def resend_activation_email!
    setup_activation
    send_activation_needed_email!
  end

  def iseeker?
    self.type.eql?("Iseeker")
  end

  def igiver?
    self.type.eql?("Igiver")
  end
end
