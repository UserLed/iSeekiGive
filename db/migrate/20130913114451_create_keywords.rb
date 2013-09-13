class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.text :story_keyword
      t.integer :game_id

      t.timestamps
    end
  end
end
