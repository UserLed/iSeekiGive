class Popup < ActiveRecord::Base
  attr_accessible :action, :status, :user_id, :controller

  belongs_to :user
end
