class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :user_id
      t.string :day
      t.string :time
      t.string :time_format

      t.timestamps
    end

    add_index :time_slots, :user_id
  end
end
