class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.integer :sender_id
      t.integer :recipient_id
      t.string :subject
      t.text :content
      t.string :uid
      t.string :attach_file

      t.boolean :is_read, :default => 0
      t.boolean :is_starred, :default => 0
      t.boolean :is_archived, :default => 0

      t.timestamps
    end
  end
end
