class RenameGiverIdToUserId < ActiveRecord::Migration
  def up
  	rename_column :games, :giver_id, :user_id
  	rename_column :perspectives, :giver_id, :user_id
  end

  def down
  	rename_column :games, :user_id, :giver_id
  	rename_column :perspectives, :user_id, :giver_id
  end
end
