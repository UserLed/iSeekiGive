class Experience < ActiveRecord::Base
  attr_accessible :company_name, :end_date, :start_date, :title, :user_id,
    :feelings

  belongs_to :user
  has_and_belongs_to_many :skills

  scope :not_rated, where(:feelings => nil)

  def update_experience_with_skill(params)
    self.skills.delete_all
    if params[:skills].present?
      params[:skills].each do |skill_id|
        skill = Skill.find(skill_id)
        self.skills << skill if skill.present?
      end
    end
  end

  def self.record_exists(e)
    self.where(:company_name => e.company_name, :start_date => e.start_date, :end_date => e.end_date).present?
  end
end