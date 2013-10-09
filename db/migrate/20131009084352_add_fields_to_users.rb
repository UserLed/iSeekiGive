class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :descriptions, :string
    add_column :users, :date_of_birth, :datetime
  end
end
