class CreateExperiencesSkillsJoin < ActiveRecord::Migration
  def change
    create_table :experiences_skills, :id => false do |t|
      t.integer :experience_id
      t.integer :skill_id
    end
  end
end
