class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :giver_id
      t.boolean :change_major,        :default => 0
      t.text    :study_majors
      t.boolean  :another_locations,  :default => 0
      t.text  :locations
      t.text    :good_story
      t.text    :bad_story
      t.text    :ugly_story

      t.timestamps
    end
  end
end
