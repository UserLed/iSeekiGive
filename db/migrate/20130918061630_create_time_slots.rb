class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.integer :giver_id
      t.string :day
      t.string :time
      t.string :time_format

      t.timestamps
    end
  end
end
