class CreatePopups < ActiveRecord::Migration
  def change
    create_table :popups do |t|
      t.string :controller
      t.string :action
      t.integer :user_id
      t.boolean :status, :default => true

      t.timestamps
    end
  end
end
