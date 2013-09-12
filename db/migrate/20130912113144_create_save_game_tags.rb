class CreateSaveGameTags < ActiveRecord::Migration
  def change
    create_table :save_game_tags do |t|
      t.string :tag_name
      t.string :experience_name
      t.integer :user_id

      t.timestamps
    end
  end
end
