class FixColumnNameOfMessages < ActiveRecord::Migration
  def up
    rename_column :messages, :from_id, :sender_id
    rename_column :messages, :to_id, :recipient_id
  end

  def down
    rename_column :messages, :sender_id, :from_id
    rename_column :messages, :recipient_id, :to_id
  end
end
