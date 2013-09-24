class Seeker < User
  has_many :schedules, :dependent => :destroy

end