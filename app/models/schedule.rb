class Schedule < ActiveRecord::Base
  attr_accessible :giver_id, :schedule_time, :seeker_id, :status
  belongs_to :giver
  belongs_to :seeker
end
