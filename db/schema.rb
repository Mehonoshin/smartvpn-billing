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

ActiveRecord::Schema.define(version: 2019_01_22_184018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "server_id"
    t.float "traffic_in"
    t.float "traffic_out"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "option_attributes"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
  end

  create_table "options_plans", id: false, force: :cascade do |t|
    t.bigint "plan_id"
    t.bigint "option_id"
    t.index ["option_id"], name: "index_options_plans_on_option_id"
    t.index ["plan_id"], name: "index_options_plans_on_plan_id"
  end

  create_table "pay_systems", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "state"
    t.string "currency", default: "usd"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "amount"
    t.integer "pay_system_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "usd_amount", precision: 12, scale: 2
    t.boolean "manual_payment", default: false
    t.text "comment"
  end

  create_table "plan_has_servers", force: :cascade do |t|
    t.integer "server_id"
    t.integer "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.text "description"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "special", default: false
    t.boolean "enabled", default: false
    t.hstore "option_prices"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promos", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.date "date_from"
    t.date "date_to"
    t.string "promoter_type"
    t.string "promo_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.hstore "attrs"
    t.string "state"
  end

  create_table "promotions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "promo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "promo_id"], name: "index_promotions_on_user_id_and_promo_id", unique: true
  end

  create_table "proxy_connects", force: :cascade do |t|
    t.integer "user_id"
    t.integer "proxy_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proxy_nodes", force: :cascade do |t|
    t.string "host"
    t.integer "port"
    t.string "country"
    t.string "location"
    t.integer "ping"
    t.integer "bandwidth"
    t.string "protocol"
    t.string "anonymity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "referrer_rewards", force: :cascade do |t|
    t.decimal "amount"
    t.integer "operation_id"
    t.integer "referrer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servers", force: :cascade do |t|
    t.string "hostname"
    t.string "ip_address"
    t.string "auth_key"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "config"
    t.string "protocol", default: "udp"
    t.integer "port", default: 443
    t.string "country_code", default: "de"
    t.text "server_crt"
    t.text "client_crt"
    t.text "client_key"
    t.index ["hostname"], name: "index_servers_on_hostname", unique: true
  end

  create_table "user_options", force: :cascade do |t|
    t.integer "user_id"
    t.integer "option_id"
    t.hstore "attrs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "enabled"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "balance", default: "0.0"
    t.integer "plan_id"
    t.string "vpn_login"
    t.string "vpn_password"
    t.string "state"
    t.integer "can_not_withdraw_counter", default: 0
    t.string "reflink"
    t.integer "referrer_id"
    t.integer "period_length"
    t.datetime "test_period_started_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "withdrawal_prolongations", force: :cascade do |t|
    t.integer "withdrawal_id"
    t.integer "days_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "withdrawals", force: :cascade do |t|
    t.decimal "amount"
    t.integer "user_id"
    t.integer "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
