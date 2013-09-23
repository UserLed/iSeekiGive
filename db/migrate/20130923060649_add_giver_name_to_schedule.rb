class AddGiverNameToSchedule < ActiveRecord::Migration
  def change
  	add_column :schedules,:seeker_name, :string
  end
end
