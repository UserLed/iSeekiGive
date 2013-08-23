class AddPromotionalNewsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :promotional_news, :boolean, :default => false
  end
end
