class AddGiverNameToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :giver_name, :string
  end
end
