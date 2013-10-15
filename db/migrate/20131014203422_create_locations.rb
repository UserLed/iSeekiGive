class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end

    add_index :locations, :user_id
  end
end
