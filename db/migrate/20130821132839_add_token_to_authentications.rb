class AddTokenToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :token, :string
    add_column :authentications, :secret, :string
    add_column :authentications, :expires_at, :datetime
  end
end
