class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_method, :string
    add_column :users, :skype_id, :string
    add_column :users, :contact_number, :string
    add_column :users, :other_contact_details, :string
  end
end
