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

ActiveRecord::Schema.define(version: 20150125141501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "admins", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.string   "encrypted_password", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connections", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "server_id"
    t.float    "traffic_in"
    t.float    "traffic_out"
    t.string   "type",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "option_attributes"
  end

  create_table "options", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 255
  end

  create_table "options_plans", id: false, force: :cascade do |t|
    t.integer "plan_id"
    t.integer "option_id"
  end

  create_table "pay_systems", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "state",       limit: 255
    t.string   "currency",    limit: 255, default: "usd"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.integer  "pay_system_id"
    t.string   "state",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "usd_amount",                 precision: 12, scale: 2
    t.boolean  "manual_payment",                                      default: false
    t.text     "comment"
  end

  create_table "plan_has_servers", force: :cascade do |t|
    t.integer  "server_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.decimal  "price"
    t.text     "description"
    t.string   "code",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "special",                   default: false
    t.boolean  "enabled",                   default: false
    t.hstore   "option_prices"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body"
    t.string   "tags",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promos", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "type",          limit: 255
    t.date     "date_from"
    t.date     "date_to"
    t.string   "promoter_type", limit: 255
    t.string   "promo_code",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "attrs",                     default: {}
    t.string   "state",         limit: 255
  end

  create_table "promotions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "promo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promotions", ["user_id", "promo_id"], name: "index_promotions_on_user_id_and_promo_id", unique: true, using: :btree

  create_table "proxy_connects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "proxy_id"
    t.string   "state",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proxy_nodes", force: :cascade do |t|
    t.string   "host",       limit: 255
    t.integer  "port"
    t.string   "country",    limit: 255
    t.string   "location",   limit: 255
    t.integer  "ping"
    t.integer  "bandwidth"
    t.string   "protocol",   limit: 255
    t.string   "anonymity",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrer_rewards", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "operation_id"
    t.integer  "referrer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "servers", force: :cascade do |t|
    t.string   "hostname",     limit: 255
    t.string   "ip_address",   limit: 255
    t.string   "auth_key",     limit: 255
    t.string   "state",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "config",       limit: 255
    t.string   "protocol",     limit: 255, default: "udp"
    t.integer  "port",                     default: 443
    t.string   "country_code", limit: 255, default: "de"
  end

  add_index "servers", ["hostname"], name: "index_servers_on_hostname", unique: true, using: :btree

  create_table "user_options", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "option_id"
    t.hstore   "attrs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",      limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    limit: 255, default: "",    null: false
    t.string   "encrypted_password",       limit: 255, default: "",    null: false
    t.string   "reset_password_token",     limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: 255
    t.string   "last_sign_in_ip",          limit: 255
    t.string   "confirmation_token",       limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",        limit: 255
    t.integer  "failed_attempts",                      default: 0
    t.string   "unlock_token",             limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "balance",                              default: 0.0
    t.integer  "plan_id"
    t.string   "vpn_login",                limit: 255
    t.string   "vpn_password",             limit: 255
    t.string   "state",                    limit: 255
    t.integer  "can_not_withdraw_counter",             default: 0
    t.string   "reflink",                  limit: 255
    t.integer  "referrer_id"
    t.boolean  "test_period_enabled",                  default: false
    t.integer  "period_length"
    t.datetime "test_period_started_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "withdrawal_prolongations", force: :cascade do |t|
    t.integer  "withdrawal_id"
    t.integer  "days_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "withdrawals", force: :cascade do |t|
    t.decimal  "amount"
    t.integer  "user_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
