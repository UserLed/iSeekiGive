class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :giver_id
      t.integer :seeker_id
      t.string :schedule_time
      t.string :description
      t.string :status, :default => "pending"

      t.timestamps
    end

    add_index :schedules, :giver_id
    add_index :schedules, :seeker_id
  end
end
