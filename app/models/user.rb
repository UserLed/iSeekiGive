class User < ActiveRecord::Base
  mount_uploader :profile_photo, ProfilePhotoUploader
  mount_uploader :cover_photo, CoverPhotoUploader

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation,
    :role, :display_name, :gender, :date_of_birth, :location, :how_hear,
    :profile_photo, :cover_photo, :descriptions, :time_zone, :level,
    :promotional_news, :considered_fields

  attr_accessible :authentications_attributes, :locations_attributes
  
  attr_accessor :password_confirmation

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates_uniqueness_of :email, :message =>" This %{value} email is already registered"
  validates :location, :presence => true
  validates_length_of :password, :minimum => 6, :if => :password
  validates_confirmation_of :password, :if => :password
  
  has_many :authentications,    :dependent => :destroy
  has_many :connections,        :dependent => :destroy
    
  has_many :educations,         :dependent => :destroy
  has_many :experiences,        :dependent => :destroy
  has_many :popups,             :dependent => :destroy
  has_one  :phone_number,       :dependent => :destroy
  has_many :tags,               :dependent => :destroy
  has_one  :billing_setting,    :dependent => :destroy
  has_many :time_slots,         :dependent => :destroy
  has_many :perspectives,       :dependent => :destroy
  has_many :saved_perspectives, :dependent => :destroy
  has_many :languages,          :dependent => :destroy
  has_many :locations,          :dependent => :destroy

  accepts_nested_attributes_for :authentications
  accepts_nested_attributes_for :educations
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :experiences
  accepts_nested_attributes_for :languages, :allow_destroy => true
  accepts_nested_attributes_for :locations, :allow_destroy => true

  before_create {|user| user.display_name = user.first_name }

  before_save :split_tags
  
  HOW_HEAR = [
    ["By Friend"],
    ["Internet Search"],
    ["Advertisement"],
    ["Others"]
  ]

  def split_tags
    if self.considered_fields_was.blank? and self.considered_fields.present?
      self.considered_fields.split(/[,]|[,\s]/).each do |value|
        if value.size > 0
          tag = self.tags.new(:name => value)
          tag.save
        end
      end
    end
  end

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
    self.role.eql?("Seeker")
  end

  def giver?
    self.role.eql?("Giver")
  end

  def linkedin_connected?
    self.connections.where(:provider => "linkedin").present? or
      self.authentications.where(:provider => "linkedin").present? ? true : false
  end

  def facebook_connected?
    self.connections.where(:provider => "facebook").present? or
      self.authentications.where(:provider => "facebook").present? ? true : false
  end

  def facebook
    self.authentications.find_by_provider("facebook") || self.connections.find_by_provider("facebook")
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

  def have_linked_in_account?
    self.connections.present?
  end

  def connection_info(provider)
    self.connections.where(:provider =>provider)
  end

end
