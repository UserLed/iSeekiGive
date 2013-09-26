class AddChangeMajorsToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :changed_majors, :boolean
    add_column :educations, :fields_of_study, :text
  end
end
