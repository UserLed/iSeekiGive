class AddAnonymousToGames < ActiveRecord::Migration
  def change
    add_column :games, :anomymous, :boolean, :default => false
  end
end
