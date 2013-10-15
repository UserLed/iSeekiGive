class CreatePopups < ActiveRecord::Migration
  def change
    create_table :popups do |t|
      t.integer :user_id
      t.string :controller
      t.string :action
      t.boolean :status, :default => true

      t.timestamps
    end

    add_index :popups, :user_id
  end
end
