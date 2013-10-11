class Schedule < ActiveRecord::Base
  attr_accessible :user_id, :schedule_time, :seeker_id, :status
  belongs_to :user
end
