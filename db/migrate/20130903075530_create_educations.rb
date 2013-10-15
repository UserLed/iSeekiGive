class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :user_id
      t.string :school_name
      t.string :field_of_study
      t.string :degree
      t.date :start_date
      t.date :end_date
      t.integer :linkedin_id

      t.timestamps
    end

    add_index :educations, :user_id
  end
end
