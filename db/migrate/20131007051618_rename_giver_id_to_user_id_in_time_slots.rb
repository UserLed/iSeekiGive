class RenameGiverIdToUserIdInTimeSlots < ActiveRecord::Migration
  def up
  	rename_column :time_slots, :giver_id, :user_id
  end

  def down
  	rename_column :time_slots, :user_id, :giver_id
  end
end
