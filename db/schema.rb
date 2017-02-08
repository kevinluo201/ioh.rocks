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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170208022643) do

  create_table "live_departments", force: :cascade do |t|
    t.string  "name",      limit: 255
    t.integer "group",     limit: 4
    t.integer "dep_class", limit: 4
  end

  create_table "live_events", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "signup_end"
    t.boolean  "active"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "channels",   limit: 4
  end

  create_table "live_schools", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "live_time_appointments", force: :cascade do |t|
    t.integer  "live_id",        limit: 4
    t.integer  "live_time_id",   limit: 4
    t.boolean  "final_decision"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel",        limit: 255
  end

  add_index "live_time_appointments", ["live_id"], name: "index_live_time_appointments_on_live_id", using: :btree
  add_index "live_time_appointments", ["live_time_id"], name: "index_live_time_appointments_on_live_time_id", using: :btree

  create_table "live_times", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "live_event_id", limit: 4
  end

  create_table "live_times_lives", force: :cascade do |t|
    t.integer "live_id",      limit: 4
    t.integer "live_time_id", limit: 4
  end

  add_index "live_times_lives", ["live_id"], name: "index_live_times_lives_on_live_id", using: :btree
  add_index "live_times_lives", ["live_time_id"], name: "index_live_times_lives_on_live_time_id", using: :btree

  create_table "lives", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "live_school_id",     limit: 4
    t.integer  "live_department_id", limit: 4
    t.string   "title",              limit: 255
    t.string   "gmail",              limit: 255
    t.string   "fb_url",             limit: 255
    t.string   "phone",              limit: 255
    t.boolean  "stream_201602"
    t.string   "location",           limit: 255
    t.string   "ioh_url",            limit: 255
    t.text     "feedback",           limit: 4294967295
    t.string   "school",             limit: 255
    t.string   "department",         limit: 255
    t.integer  "time_count",         limit: 4
    t.string   "banner_link",        limit: 255
  end

  add_index "lives", ["live_department_id"], name: "index_lives_on_live_department_id", using: :btree
  add_index "lives", ["live_school_id"], name: "index_lives_on_live_school_id", using: :btree

  create_table "posters", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.boolean  "use_avatar"
    t.string   "name",                limit: 255
    t.text     "description",         limit: 65535
    t.string   "info_one",            limit: 255
    t.boolean  "info_one_red"
    t.string   "info_two",            limit: 255
    t.boolean  "info_two_red"
    t.string   "info_three",          limit: 255
    t.boolean  "info_three_red"
    t.string   "location",            limit: 255
    t.boolean  "location_white"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "last_edit_id",        limit: 4
    t.string   "last_user",           limit: 255
    t.boolean  "avatar_upload"
    t.string   "avatar",              limit: 255
    t.string   "background",          limit: 255
    t.string   "original_avatar",     limit: 255
    t.string   "original_background", limit: 255
    t.string   "poster",              limit: 255
  end

  add_index "posters", ["last_edit_id"], name: "index_posters_on_last_edit_id", using: :btree
  add_index "posters", ["user_id"], name: "index_posters_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "streams", force: :cascade do |t|
    t.string  "name",               limit: 255
    t.string  "chennal",            limit: 255
    t.string  "live_host",          limit: 255
    t.integer "live_id",            limit: 4
    t.integer "live_time_id",       limit: 4
    t.string  "youtube_url",        limit: 255
    t.boolean "phone_contact",                  default: false
    t.string  "qa_link",            limit: 255
    t.string  "doc_naming",         limit: 255
    t.string  "stream_naming",      limit: 255
    t.string  "test_record",        limit: 255
    t.boolean "move_to_part_3",                 default: false
    t.string  "banner_status",      limit: 255
    t.string  "embed_link_status",  limit: 255
    t.boolean "no_show",                        default: false
    t.boolean "in_studio",                      default: false
    t.boolean "video_download",                 default: false
    t.boolean "speaker_screenshot",             default: false
    t.string  "youtube_naming",     limit: 255
    t.boolean "save_to_hard_drive",             default: false
    t.boolean "paste_survey_link",              default: false
    t.boolean "audio_agree",                    default: false
  end

  add_index "streams", ["live_id"], name: "index_streams_on_live_id", using: :btree
  add_index "streams", ["live_time_id"], name: "index_streams_on_live_time_id", using: :btree

  create_table "talks", force: :cascade do |t|
    t.integer "ioh_id",             limit: 4
    t.string  "title",              limit: 255
    t.string  "post_name",          limit: 255
    t.integer "live_school_id",     limit: 4
    t.integer "live_department_id", limit: 4
  end

  add_index "talks", ["live_department_id"], name: "index_talks_on_live_department_id", using: :btree
  add_index "talks", ["live_school_id"], name: "index_talks_on_live_school_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "account_name",           limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "role_id",                limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

  add_foreign_key "lives", "live_departments"
  add_foreign_key "lives", "live_schools"
  add_foreign_key "posters", "users"
  add_foreign_key "posters", "users", column: "last_edit_id"
  add_foreign_key "streams", "live_times"
  add_foreign_key "streams", "lives", column: "live_id"
  add_foreign_key "talks", "live_departments"
  add_foreign_key "talks", "live_schools"
  add_foreign_key "users", "roles"
end
