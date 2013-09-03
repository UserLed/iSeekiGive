class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.date :start_date
      t.date :end_date
      t.string :degree
      t.string :field_of_study
      t.integer :user_id

      t.timestamps
    end
  end
end
