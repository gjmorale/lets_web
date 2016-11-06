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

ActiveRecord::Schema.define(version: 20161104154154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.integer  "user_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true, using: :btree
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "admissions", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "event_id"
    t.index ["event_id"], name: "index_admissions_on_event_id", using: :btree
    t.index ["user_id"], name: "index_admissions_on_user_id", using: :btree
  end

  create_table "clubs", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "combos", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "buyable_from"
    t.datetime "buyable_until"
    t.integer  "min_age"
    t.integer  "max_age"
    t.integer  "gender"
    t.integer  "stock"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "event_id"
    t.index ["event_id"], name: "index_combos_on_event_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "capacity"
    t.integer  "min_age"
    t.integer  "max_age"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "open_date"
    t.datetime "close_date"
    t.integer  "producer_id"
    t.index ["producer_id"], name: "index_events_on_producer_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "price"
    t.datetime "redeem_start"
    t.datetime "redeem_finish"
    t.integer  "combo_id"
    t.integer  "product_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["combo_id"], name: "index_offers_on_combo_id", using: :btree
    t.index ["product_id"], name: "index_offers_on_product_id", using: :btree
  end

  create_table "prod_owners", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "producer_id"
    t.string   "role"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["account_id", "producer_id"], name: "index_prod_owners_on_account_id_and_producer_id", unique: true, using: :btree
    t.index ["account_id"], name: "index_prod_owners_on_account_id", using: :btree
    t.index ["producer_id"], name: "index_prod_owners_on_producer_id", using: :btree
  end

  create_table "producers", force: :cascade do |t|
    t.string   "name"
    t.string   "fantasy_name"
    t.string   "social_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "min_age"
    t.integer  "product_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.datetime "date"
    t.string   "qr"
    t.integer  "price_paid"
    t.integer  "status"
    t.integer  "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "buyer_id"
    t.index ["buyer_id"], name: "index_purchases_on_buyer_id", using: :btree
    t.index ["offer_id"], name: "index_purchases_on_offer_id", using: :btree
  end

  create_table "table_accounts_producers", force: :cascade do |t|
    t.string "account"
    t.string "producer"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.integer  "gender"
    t.string   "social_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_id"], name: "index_users_on_social_id", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "admissions", "events"
  add_foreign_key "admissions", "users"
  add_foreign_key "combos", "events"
  add_foreign_key "events", "producers"
  add_foreign_key "offers", "combos"
  add_foreign_key "offers", "products"
  add_foreign_key "prod_owners", "accounts"
  add_foreign_key "prod_owners", "producers"
  add_foreign_key "purchases", "offers"
  add_foreign_key "purchases", "users", column: "buyer_id"
end
