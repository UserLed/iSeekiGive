class AddCompletedStepsToGames < ActiveRecord::Migration
  def change
    add_column :games, :completed_step_1, :boolean, :default => false
    add_column :games, :completed_step_2, :boolean, :default => false
    add_column :games, :completed_step_3, :boolean, :default => false
  end
end
