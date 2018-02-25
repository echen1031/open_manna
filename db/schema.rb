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

ActiveRecord::Schema.define(version: 20180212055114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "sms_client_loggers", force: :cascade do |t|
    t.string   "status_code"
    t.string   "status_text"
    t.string   "message_id"
    t.string   "to"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscription_verses", force: :cascade do |t|
    t.integer  "subscription_id", null: false
    t.integer  "verse_id",        null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "subscription_verses", ["subscription_id"], name: "index_subscription_verses_on_subscription_id", using: :btree
  add_index "subscription_verses", ["verse_id"], name: "index_subscription_verses_on_verse_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "send_monday",      default: false
    t.boolean  "send_tuesday",     default: false
    t.boolean  "send_wednesday",   default: false
    t.boolean  "send_thursday",    default: false
    t.boolean  "send_friday",      default: false
    t.boolean  "send_saturday",    default: false
    t.boolean  "send_sunday",      default: false
    t.integer  "send_hour"
    t.string   "time_zone"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "phone_number"
    t.string   "name"
    t.boolean  "active",           default: false, null: false
    t.integer  "stored_verse_ids", default: [],                 array: true
  end

  add_index "subscriptions", ["stored_verse_ids"], name: "index_subscriptions_on_stored_verse_ids", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "verses", force: :cascade do |t|
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text"
  end

end
