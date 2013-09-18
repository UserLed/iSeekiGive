class Giver < User
  has_one  :game,         :dependent => :destroy
  has_many :time_slots,   :dependent => :destroy
  
end