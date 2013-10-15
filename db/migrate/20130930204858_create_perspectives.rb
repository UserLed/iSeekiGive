class CreatePerspectives < ActiveRecord::Migration
  def change
    create_table :perspectives do |t|
      t.integer :user_id
      t.string :story_type
      t.text :story
      t.boolean :anonymous,   :default => false

      t.integer :viewed, :default => 0
      t.integer :saved,  :default => 0

      t.timestamps
    end

    add_index :perspectives, :user_id
    add_index :perspectives, :story_type
  end
end
