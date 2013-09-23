class RenameColumnsToPayments < ActiveRecord::Migration
  def up
    rename_column :payments, :charge_amount, :amount
    rename_column :payments, :charge_id, :transaction_id
    rename_column :payments, :event_id, :schedule_id
    change_column :payments, :transaction_id, :string
  end

  def down
    rename_column :payments, :amount, :charge_amount
    rename_column :payments, :transaction_id, :charge_id
    rename_column :payments, :schedule_id, :event_id
    change_column :payments, :transaction_id, :integer
  end
end
