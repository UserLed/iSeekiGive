class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :giver_id
      t.boolean  :another_locations,  :default => false
      t.text  :locations
      t.boolean :completed_step_1,      :default => false
      t.boolean :completed_step_2,       :default => false
      t.boolean :completed_step_3,      :default => false

      t.timestamps
    end
  end
end
