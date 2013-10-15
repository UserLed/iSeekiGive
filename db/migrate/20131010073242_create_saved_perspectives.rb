class CreateSavedPerspectives < ActiveRecord::Migration
  def change
    create_table :saved_perspectives do |t|
      t.integer :user_id
      t.integer :perspective_id

      t.timestamps
    end

    add_index :saved_perspectives, :user_id
    add_index :saved_perspectives, :perspective_id
  end
end
