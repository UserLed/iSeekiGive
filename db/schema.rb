# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131009084352) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "provider",   :null => false
    t.string   "uid",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "token"
    t.string   "secret"
    t.datetime "expires_at"
  end

  create_table "billing_settings", :force => true do |t|
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "user_id"
    t.string   "stripe_id"
    t.string   "card_last_four_digits"
    t.date     "card_expiry_date"
    t.string   "card_type"
    t.string   "card_holder_name"
  end

  create_table "connections", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.datetime "expires_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "educations", :force => true do |t|
    t.string   "school_name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "degree"
    t.string   "field_of_study"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "feelings"
    t.boolean  "changed_majors"
    t.text     "fields_of_study"
  end

  create_table "educations_skills", :id => false, :force => true do |t|
    t.integer "education_id"
    t.integer "skill_id"
  end

  create_table "experiences", :force => true do |t|
    t.string   "title"
    t.string   "company_name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "feelings"
  end

  create_table "experiences_skills", :id => false, :force => true do |t|
    t.integer "experience_id"
    t.integer "skill_id"
  end

  create_table "games", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "another_locations", :default => false
    t.text     "locations"
    t.boolean  "completed_step_1",  :default => false
    t.boolean  "completed_step_2",  :default => false
    t.boolean  "completed_step_3",  :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "keywords", :force => true do |t|
    t.text     "story_keyword"
    t.integer  "game_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "content"
    t.string   "uid"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "is_read",      :default => false
    t.boolean  "is_starred",   :default => false
    t.boolean  "is_archived",  :default => false
    t.string   "attach_file"
  end

  create_table "payments", :force => true do |t|
    t.string   "transaction_id"
    t.integer  "schedule_id"
    t.float    "amount"
    t.string   "status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "user_id"
    t.boolean  "paid"
  end

  create_table "perspective_tags", :force => true do |t|
    t.integer  "perspective_id"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "perspectives", :force => true do |t|
    t.integer  "user_id"
    t.string   "story_type"
    t.text     "story"
    t.boolean  "anonymous",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "phone_numbers", :force => true do |t|
    t.integer  "user_id"
    t.string   "number"
    t.string   "pin"
    t.boolean  "verified",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "popups", :force => true do |t|
    t.string   "controller"
    t.string   "action"
    t.integer  "user_id"
    t.boolean  "status",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "save_game_tags", :force => true do |t|
    t.string   "tag_name"
    t.string   "experience_name"
    t.integer  "user_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "schedules", :force => true do |t|
    t.integer  "giver_id"
    t.integer  "seeker_id"
    t.string   "schedule_time"
    t.string   "description"
    t.string   "status",        :default => "pending"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "seeker_name"
    t.string   "giver_name"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "time_slots", :force => true do |t|
    t.integer  "user_id"
    t.string   "day"
    t.string   "time"
    t.string   "time_format"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                              :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country"
    t.string   "hear"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "type"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.boolean  "promotional_news",                :default => false
    t.string   "city"
    t.boolean  "linkedin_update",                 :default => false
    t.string   "profile_photo"
    t.string   "cover_photo"
    t.integer  "level",                           :default => 1
    t.string   "session_method"
    t.string   "skype_id"
    t.string   "contact_number"
    t.string   "other_contact_details"
    t.string   "user_time_zone"
    t.string   "gender"
    t.string   "descriptions"
    t.datetime "date_of_birth"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
