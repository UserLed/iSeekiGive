class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :giver_id
      t.boolean :change_major,        :default => false
      t.text    :study_majors
      t.boolean  :another_locations,  :default => false
      t.text  :locations
      t.text    :good_story
      t.text    :bad_story
      t.text    :ugly_story
      t.text    :good_keywords
      t.text    :bad_keywords
      t.text    :ugly_keywords
      t.boolean :good_anonymous,      :default => false
      t.boolean :bad_anonymous,       :default => false
      t.boolean :ugly_anonymous,      :default => false

      t.timestamps
    end
  end
end
