class AddColumnToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :is_read, :boolean, :default => 0
    add_column :messages, :is_starred, :boolean, :default => 0
    add_column :messages, :is_archived, :boolean, :default => 0
  end
end
