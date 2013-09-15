class AddFeelingsToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :feelings, :string
  end
end
