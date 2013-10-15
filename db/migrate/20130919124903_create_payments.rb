class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.float :amount
      t.string :transaction_id
      t.string :status
      t.boolean :paid

      t.timestamps
    end
  end
end