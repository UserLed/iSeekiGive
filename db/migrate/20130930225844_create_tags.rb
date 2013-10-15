class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id
      t.string :name
      t.integer :linkedin_id
      t.string  :linkedin_data_type

      t.timestamps
    end

    add_index :tags, :user_id
    add_index :tags, :name
  end
end
