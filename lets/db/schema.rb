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

ActiveRecord::Schema.define(version: 20160808190928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.integer  "admission_level"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
    t.integer  "grants_admission"
    t.integer  "admission_level"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.integer  "gender"
    t.string   "social_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
