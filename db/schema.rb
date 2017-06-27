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

ActiveRecord::Schema.define(version: 20161021144300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "image"
    t.index ["user_id"], name: "index_badges_on_user_id", using: :btree
  end

  create_table "badges_users", id: false, force: :cascade do |t|
    t.integer "badge_id"
    t.integer "user_id"
  end

  create_table "harvests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "animal_type"
    t.string   "weapon_type"
    t.datetime "date_of_harvest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "weight"
    t.string   "image"
    t.string   "latitude"
    t.string   "longitude"
    t.index ["user_id"], name: "index_harvests_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "avatar"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "points"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "badges", "users"
end
