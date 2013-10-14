class RemoveCityCountryFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :city
    remove_column :users, :country
  end

  def down
    add_column :users, :country, :string
    add_column :users, :city, :string
  end
end
