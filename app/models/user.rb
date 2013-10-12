class User < ActiveRecord::Base
  mount_uploader :profile_photo, PhotoUploader
  mount_uploader :cover_photo, PhotoUploader

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  attr_accessible :email, :first_name, :last_name, :country, :hear, :password,
    :password_confirmation, :authentications_attributes, :type, :promotional_news,
    :city, :linkedin_update, :profile_photo, :cover_photo, :level, :session_method,
    :skype_id, :contact_number, :other_contact_details, :user_time_zone
  
  attr_accessor :password_confirmation

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates_uniqueness_of :email, :message =>" This %{value}  email is already registered"
  validates :country, :presence => true
  validates_length_of :password, :minimum => 3, :if => :password
  validates_confirmation_of :password, :if => :password
  
  has_many :authentications,    :dependent => :destroy
  has_many :educations,         :dependent => :destroy
  has_many :skills,             :dependent => :destroy
  has_many :experiences,        :dependent => :destroy
  has_many :connections,        :dependent => :destroy
  has_many :popups,             :dependent => :destroy
  has_one  :phone_number,       :dependent => :destroy
  has_many :tags,               :dependent => :destroy
  has_one  :billing_setting,    :dependent => :destroy
  #has_many :schedules,          :dependent => :destroy
  has_one  :game,               :dependent => :destroy
  has_many :time_slots,         :dependent => :destroy
  has_many :perspectives,       :dependent => :destroy
  has_many :saved_perspectives, :dependent => :destroy 

  
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

  def step
    %w[personal_details photos educations_experiences_social skills trust_and_verifications review]
  end

  def name
    "#{first_name} #{last_name}"
  end

  alias_method :full_name, :name

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

  def seeker?
    self.type.eql?("Seeker")
  end

  def giver?
    self.type.eql?("Giver")
  end

  def linkedin_connected?
    self.connections.where(:provider => "linkedin").present? or
      self.authentications.where(:provider => "linkedin").present? ? true : false
  end

  def facebook_connected?
    self.connections.where(:provider => "facebook").present? or
      self.authentications.where(:provider => "facebook").present? ? true : false
  end

  def twitter_connected?
    self.connections.where(:provider => "twitter").present? or
      self.authentications.where(:provider => "twitter").present? ? true : false
  end

  def phone_verified?
    self.phone_number.present? and self.phone_number.verified?
  end

  def show_this_popup(controller, action)
    popup = self.popups.where("controller = ? AND action = ?", controller, action)
    popup.blank? or popup.first.status == true
  end

  def current_location
    l = []
    l << self.city if self.city.present?
    l << self.country if self.country.present?
    l.join(", ")
  end

  def self.email_verified?(email)
    User.where(:email => email).present? ? false : true
  end

  def good_perspective
    if @good_perspective.blank?
      perspective = self.perspectives.find_by_story_type("The Good")
      @good_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Good")
    end
    @good_perspective
  end

  def bad_perspective
    if @bad_perspective.blank?
      perspective = self.perspectives.find_by_story_type("The Bad")
      @bad_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Bad")
    end
    @bad_perspective
  end

  def ugly_perspective
    if @ugly_perspective.blank?
      perspective = self.perspectives.find_by_story_type("The Ugly")
      @ugly_perspective = perspective.present? ? perspective : self.perspectives.new(:story_type => "The Ugly")
    end
    @ugly_perspective
  end

end
