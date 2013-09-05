class Connection < ActiveRecord::Base
  attr_accessible :user_id, :uid, :provider, :secret, :expires_at

  belongs_to :user
end