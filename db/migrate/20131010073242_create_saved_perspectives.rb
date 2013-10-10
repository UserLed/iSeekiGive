class CreateSavedPerspectives < ActiveRecord::Migration
  def change
    create_table :saved_perspectives do |t|
      t.integer :user_id
      t.integer :perspective_id

      t.timestamps
    end
  end
end
