class Education < ActiveRecord::Base
  attr_accessible :degree, :end_date, :field_of_study, :school_name, :start_date, :user_id

  belongs_to :user
  has_and_belongs_to_many :skills
end
