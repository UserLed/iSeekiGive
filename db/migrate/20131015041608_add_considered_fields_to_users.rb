class AddConsideredFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :considered_fields, :text
  end
end
