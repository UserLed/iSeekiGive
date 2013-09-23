class CreateBillingSettings < ActiveRecord::Migration
  def change
    create_table :billing_settings do |t|

      t.timestamps
    end
  end
end
