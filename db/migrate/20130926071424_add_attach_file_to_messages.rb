class AddAttachFileToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :attach_file, :string
  end
end
