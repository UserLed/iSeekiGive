class Payment < ActiveRecord::Base
  attr_accessible :amount, :transaction_id, :schedule_id, :status
end
