class CreateEducationsSkillsJoin < ActiveRecord::Migration
  def change
    create_table :educations_skills, :id => false do |t|
      t.integer :education_id
      t.integer :skill_id
    end
  end
end
