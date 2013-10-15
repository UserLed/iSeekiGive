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

ActiveRecord::Schema.define(:version => 20131015041608) do

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
    t.string   "token"
    t.string   "secret"
    t.datetime "expires_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "billing_settings", :force => true do |t|
    t.integer  "user_id"
    t.string   "stripe_id"
    t.string   "card_type"
    t.string   "card_holder_name"
    t.string   "card_last_four_digits"
    t.string   "card_expiry_date"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
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

  add_index "connections", ["user_id"], :name => "index_connections_on_user_id"

  create_table "educations", :force => true do |t|
    t.integer  "user_id"
    t.string   "school_name"
    t.string   "field_of_study"
    t.string   "degree"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "linkedin_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "educations", ["user_id"], :name => "index_educations_on_user_id"

  create_table "experiences", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "company_name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "linkedin_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "experiences", ["user_id"], :name => "index_experiences_on_user_id"

  create_table "languages", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "linkedin_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "languages", ["user_id"], :name => "index_languages_on_user_id"

  create_table "locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "locations", ["user_id"], :name => "index_locations_on_user_id"

  create_table "messages", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "subject"
    t.text     "content"
    t.string   "uid"
    t.string   "attach_file"
    t.boolean  "is_read",      :default => false
    t.boolean  "is_starred",   :default => false
    t.boolean  "is_archived",  :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "payments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.float    "amount"
    t.string   "transaction_id"
    t.string   "status"
    t.boolean  "paid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "perspective_tags", :force => true do |t|
    t.integer  "perspective_id"
    t.string   "name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "perspective_tags", ["name"], :name => "index_perspective_tags_on_name"
  add_index "perspective_tags", ["perspective_id"], :name => "index_perspective_tags_on_perspective_id"

  create_table "perspectives", :force => true do |t|
    t.integer  "user_id"
    t.string   "story_type"
    t.text     "story"
    t.boolean  "anonymous",  :default => false
    t.integer  "viewed",     :default => 0
    t.integer  "saved",      :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "perspectives", ["story_type"], :name => "index_perspectives_on_story_type"
  add_index "perspectives", ["user_id"], :name => "index_perspectives_on_user_id"

  create_table "phone_numbers", :force => true do |t|
    t.integer  "user_id"
    t.string   "number"
    t.string   "pin"
    t.boolean  "verified",   :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "phone_numbers", ["user_id"], :name => "index_phone_numbers_on_user_id"

  create_table "popups", :force => true do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.boolean  "status",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "popups", ["user_id"], :name => "index_popups_on_user_id"

  create_table "saved_perspectives", :force => true do |t|
    t.integer  "user_id"
    t.integer  "perspective_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "saved_perspectives", ["perspective_id"], :name => "index_saved_perspectives_on_perspective_id"
  add_index "saved_perspectives", ["user_id"], :name => "index_saved_perspectives_on_user_id"

  create_table "schedules", :force => true do |t|
    t.integer  "giver_id"
    t.integer  "seeker_id"
    t.string   "schedule_time"
    t.string   "description"
    t.string   "status",        :default => "pending"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "schedules", ["giver_id"], :name => "index_schedules_on_giver_id"
  add_index "schedules", ["seeker_id"], :name => "index_schedules_on_seeker_id"

  create_table "tags", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "linkedin_id"
    t.string   "linkedin_data_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["user_id"], :name => "index_tags_on_user_id"

  create_table "time_slots", :force => true do |t|
    t.integer  "user_id"
    t.string   "day"
    t.string   "time"
    t.string   "time_format"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "time_slots", ["user_id"], :name => "index_time_slots_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                              :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "role"
    t.string   "display_name"
    t.string   "gender"
    t.date     "date_of_birth"
    t.string   "location"
    t.string   "how_hear"
    t.string   "profile_photo"
    t.string   "cover_photo"
    t.text     "descriptions"
    t.string   "time_zone"
    t.integer  "level",                           :default => 1
    t.boolean  "promotional_news",                :default => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text     "considered_fields"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["display_name"], :name => "index_users_on_display_name"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["location"], :name => "index_users_on_location"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
