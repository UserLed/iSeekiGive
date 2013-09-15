class Experience < ActiveRecord::Base
  attr_accessible :company_name, :end_date, :start_date, :title, :user_id,
    :feelings

  belongs_to :user
  has_and_belongs_to_many :skills

  scope :not_rated, where(:feelings => nil)
end