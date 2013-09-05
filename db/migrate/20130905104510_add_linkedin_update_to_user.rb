class AddLinkedinUpdateToUser < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_update, :boolean, :default => false
  end
end
