class TimeSlot < ActiveRecord::Base
  attr_accessible :day, :giver_id, :time, :time_format
end
