class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :secret, :token, :expires_at
  
  belongs_to :user

  def self.already_sign_up?(user_hash,social_type)
    return false if social_type == 'login'
    Authentication.where(:uid => user_hash[:user_info]["id"]).present? ? true :false
  end
end
