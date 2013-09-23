class Giver < User
  has_one  :game,         :dependent => :destroy
  has_many :time_slots,   :dependent => :destroy
  has_many :schedules,    :dependent => :destroy
  
end