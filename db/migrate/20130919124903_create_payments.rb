class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :charge_id
      t.integer :event_id
      t.integer :charge_amount
      t.string :status

      t.timestamps
    end
  end
end
