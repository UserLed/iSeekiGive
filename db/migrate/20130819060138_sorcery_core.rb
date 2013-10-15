class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,            :null => false # if you use this field as a username, you might want to make it :null => false.
      t.string :first_name,       :default => nil
      t.string :last_name,        :default => nil
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      t.string :role
      t.string :display_name
      t.string :gender
      t.date   :date_of_birth
      t.string :location
      t.string :how_hear
      t.string :profile_photo
      t.string :cover_photo
      t.text   :descriptions

      t.string  :time_zone
      t.integer :level,             :default => 1

      t.boolean :promotional_news,  :default => false

      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, :display_name
    add_index :users, :first_name
    add_index :users, :last_name
    add_index :users, :location
  end

  def self.down
    drop_table :users
  end
end