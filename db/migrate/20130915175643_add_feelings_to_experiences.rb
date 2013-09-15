class AddFeelingsToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :feelings, :string
  end
end
