class CreatePerspectiveTags < ActiveRecord::Migration
  def change
    create_table :perspective_tags do |t|
      t.integer :perspective_id
      t.string :name

      t.timestamps
    end

    add_index :perspective_tags, :perspective_id
    add_index :perspective_tags, :name
  end
end
