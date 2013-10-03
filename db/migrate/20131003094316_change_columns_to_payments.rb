class ChangeColumnsToPayments < ActiveRecord::Migration
  def up
    add_column :payments, :user_id, :integer
    add_column :payments, :paid, :boolean
    change_column :payments, :status, :string
    change_column :payments, :amount, :float
  end

  def down
    remove_column :payments, :user_id
    remove_column :payments, :paid
    change_column :payments, :status, :integer
    change_column :payments, :amount, :integer
  end
end
