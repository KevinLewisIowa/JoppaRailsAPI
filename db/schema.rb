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

ActiveRecord::Schema.define(version: 20190530035428) do

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

  create_table "client_heater_interactions", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "heater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status_id"
  end

  create_table "client_hose_interactions", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "heater_status_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
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

  create_table "client_notes", force: :cascade do |t|
    t.integer  "route_instance_id"
    t.integer  "client_id"
    t.string   "note"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "client_tank_interactions", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "tank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status_id"
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
    t.boolean  "deceased"
    t.boolean  "inactive"
    t.string   "inactive_description"
    t.string   "dwelling"
    t.integer  "current_camp_id"
    t.integer  "previous_camp_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.index ["first_name", "last_name"], name: "index_clients_on_first_name_and_last_name", unique: true, using: :btree
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

  create_table "heater_statuses", force: :cascade do |t|
    t.string   "status_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "heater_types", force: :cascade do |t|
    t.string   "type_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "heaters", force: :cascade do |t|
    t.integer  "heater_type_id"
    t.string   "serial_number"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "heater_status_id"
    t.string   "status_reason"
    t.boolean  "is_active"
    t.integer  "current_client_id"
  end

  create_table "location_camps", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id"
    t.boolean  "is_active"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "route_id"
    t.integer  "position"
    t.string   "notes"
    t.decimal  "longitude"
    t.decimal  "latitude"
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

  create_table "pass_tokens", force: :cascade do |t|
    t.string   "admin_password"
    t.string   "regular_password"
    t.string   "api_token"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "prayer_request_and_needs", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "detail"
    t.boolean  "is_completed"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "requested_items", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "item_description"
    t.date     "date_requested"
    t.boolean  "has_received"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "route_instance_heater_interactions", force: :cascade do |t|
    t.integer  "route_instance_id"
    t.boolean  "is_checked_out"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "heater_id"
  end

  create_table "route_instance_tank_hose_interactions", force: :cascade do |t|
    t.integer  "route_instance_id"
    t.integer  "number_hoses_out"
    t.integer  "number_hoses_in"
    t.integer  "number_tanks_out"
    t.integer  "number_tanks_in"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "route_instances", force: :cascade do |t|
    t.integer  "route_id"
    t.string   "leader_name"
    t.string   "leader_phone"
    t.boolean  "heat_route"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "number_route_members"
  end

  create_table "routes", force: :cascade do |t|
    t.string   "region"
    t.string   "name"
    t.boolean  "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tanks", force: :cascade do |t|
    t.string   "serial_number"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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
