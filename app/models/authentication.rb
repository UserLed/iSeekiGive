class Authentication < ActiveRecord::Base
  attr_accessible :user_id, :provider, :uid, :secret, :token, :expires_at
  
  belongs_to :user
end
