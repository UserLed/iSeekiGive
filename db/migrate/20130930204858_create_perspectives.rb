class CreatePerspectives < ActiveRecord::Migration
  def change
    create_table :perspectives do |t|
      t.integer :giver_id
      t.string :story_type
      t.text :story
      t.boolean :anonymous,   :default => false

      t.timestamps
    end
  end
end
