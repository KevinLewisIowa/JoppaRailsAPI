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

ActiveRecord::Schema.define(version: 20180728150747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camping_equipment_given_dates", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "camping_equipment_id"
    t.date     "date_given"
    t.boolean  "has_returned"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "camping_equipments", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_available"
    t.string   "joppa_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "client_dislikes", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "client_interactions", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "location_camp_id"
    t.boolean  "serviced"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "still_lives_here"
    t.boolean  "was_seen"
  end

  create_table "client_likes", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "preferred_name"
    t.boolean  "is_veteran"
    t.date     "birth_date"
    t.boolean  "is_aftercare"
    t.string   "shoe_size"
    t.string   "phone"
    t.string   "joppa_apartment_number"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "number_meals"
    t.string   "boot_size"
  end

  create_table "goals_and_next_steps", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "description"
    t.boolean  "is_completed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "health_concerns", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "location_camps", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "route_id"
    t.string   "name"
    t.integer  "position"
    t.string   "notes"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prayer_request_and_needs", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "detail"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "is_completed"
  end

  create_table "requested_items", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "item_description"
    t.date     "date_requested"
    t.boolean  "has_received"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "routes", force: :cascade do |t|
    t.string   "city"
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "session_token"
    t.string   "password_digest"
  end

  create_table "volunteers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "email"
    t.date     "birth_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
