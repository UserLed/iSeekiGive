class Experience < ActiveRecord::Base
  attr_accessible :company_name, :end_date, :start_date, :title, :user_id

  belongs_to :user
end
