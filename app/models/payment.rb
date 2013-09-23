class Payment < ActiveRecord::Base
  attr_accessible :charge_amount, :charge_id, :event_id, :status
end
