class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :user_id
      t.string :title
      t.string :company_name
      t.date :start_date
      t.date :end_date
      t.integer :linkedin_id

      t.timestamps
    end

    add_index :experiences, :user_id
  end
end
