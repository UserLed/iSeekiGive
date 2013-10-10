class AddViewCountToPerspectives < ActiveRecord::Migration
  def change
    add_column :perspectives, :viewed, :integer, :default => 0
  end
end
