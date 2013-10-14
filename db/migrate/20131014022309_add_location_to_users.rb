class AddLocationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :location, :string
    add_column :users, :other_locations, :text
  end
end
