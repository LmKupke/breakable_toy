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

ActiveRecord::Schema.define(version: 20160726151346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.datetime "date",         null: false
    t.string   "name",         null: false
    t.integer  "organizer_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "start_time",   null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "inviter_id",                     null: false
    t.integer  "invitee_id",                     null: false
    t.string   "status",     default: "Pending", null: false
    t.integer  "event_id",                       null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "event_id",                  null: false
    t.integer  "user_id",                   null: false
    t.boolean  "ping",       default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                      null: false
    t.string   "photo"
    t.string   "role",                   default: "member", null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "token",                                     null: false
    t.integer  "expires_at",                                null: false
    t.float    "timezone",                                  null: false
    t.string   "phonenumber"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "phone",       null: false
    t.string   "category",    null: false
    t.string   "address",     null: false
    t.string   "city",        null: false
    t.string   "postal_code", null: false
    t.string   "state_code",  null: false
    t.integer  "rating",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "photo"
    t.float    "latitude",    null: false
    t.float    "longitude",   null: false
    t.string   "url",         null: false
    t.string   "yelp_id",     null: false
  end

  create_table "venueselections", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
    t.integer "venue_id", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.integer  "venueselection_id",             null: false
    t.integer  "vote",              default: 0, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
