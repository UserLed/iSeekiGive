class Connection < ActiveRecord::Base
  attr_accessible :user_id, :uid, :provider, :secret, :expires_at

  belongs_to :user

  def self.provider_account_not_exists?(user_provider_info,provider)
    self.where(:uid =>user_provider_info[:uid],:provider => provider).present? ? false : true
  end

end