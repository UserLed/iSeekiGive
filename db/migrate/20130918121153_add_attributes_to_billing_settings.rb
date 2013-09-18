class AddAttributesToBillingSettings < ActiveRecord::Migration
  def change
    add_column :billing_settings, :user_id, :integer
    add_column :billing_settings, :stripe_id, :string
    add_column :billing_settings, :card_last_four_digits, :string
    add_column :billing_settings, :card_expiry_date, :date
    add_column :billing_settings, :card_type, :string
    add_column :billing_settings, :card_holder_name, :string
  end
end
