class CreatePerspectiveTags < ActiveRecord::Migration
  def change
    create_table :perspective_tags do |t|
      t.integer :perspective_id
      t.string :name

      t.timestamps
    end
  end
end
