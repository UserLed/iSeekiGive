class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :user_id
      t.string :number
      t.string :pin
      t.boolean :verified, :default => false

      t.timestamps
    end
  end
end
