class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :from
      t.string :to
      t.integer :from_id
      t.integer :to_id
      t.string :subject
      t.text :content
      t.string :uid

      t.timestamps
    end
  end
end
