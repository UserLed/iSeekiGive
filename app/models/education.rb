class Education < ActiveRecord::Base
  attr_accessible :degree, :end_date, :field_of_study, :school_name, :start_date, 
    :user_id, :feelings, :changed_majors, :fields_of_study

  belongs_to :user
  has_and_belongs_to_many :skills

  scope :not_rated, where(:feelings => nil)

  def update_education_with_skill(params)
    self.skills.delete_all
    if params[:skills].present?
      params[:skills].each do |skill_id|
        skill = Skill.find(skill_id)
        self.skills << skill if skill.present?
      end
    end
  end
end
