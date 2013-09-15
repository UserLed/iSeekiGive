class Giver < User
  has_one :game,     :dependent => :destroy
  
end