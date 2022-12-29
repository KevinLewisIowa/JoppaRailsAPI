# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_12_29_200358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camping_equipment_given_dates", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.integer "camping_equipment_id"
    t.date "date_given"
    t.boolean "has_returned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "camping_equipments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "is_available"
    t.string "joppa_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_dislikes", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_dwellings", force: :cascade do |t|
    t.integer "client_id"
    t.date "date_became_homeless"
    t.string "dwelling"
    t.string "notes"
    t.string "homeless_reason"
    t.boolean "first_time_homeless"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "client_heater_interactions", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.integer "heater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status_id"
  end

  create_table "client_hose_interactions", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.integer "heater_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_interactions", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.integer "location_camp_id"
    t.boolean "serviced"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "still_lives_here"
    t.boolean "was_seen"
    t.boolean "at_homeless_resource_center"
    t.datetime "serviced_date"
  end

  create_table "client_likes", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "client_notes", id: :serial, force: :cascade do |t|
    t.integer "route_instance_id"
    t.integer "client_id"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "source"
  end

  create_table "client_pets", id: :serial, force: :cascade do |t|
    t.string "pet_type"
    t.integer "quantity"
    t.boolean "food_requested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id"
    t.string "pet_name"
    t.integer "age"
  end

  create_table "client_referrals", force: :cascade do |t|
    t.integer "client_id"
    t.string "referral_type"
    t.integer "quantity"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "client_tank_interactions", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.integer "tank_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status_id"
  end

  create_table "client_tents", force: :cascade do |t|
    t.integer "client_id"
    t.string "tent_type"
    t.string "condition"
    t.datetime "date_given"
    t.string "given_by"
    t.string "setup_by"
    t.string "notes"
    t.boolean "rejected"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "preferred_name"
    t.boolean "is_veteran"
    t.date "birth_date"
    t.boolean "is_aftercare"
    t.string "shoe_size"
    t.string "phone"
    t.string "joppa_apartment_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_meals"
    t.string "boot_size"
    t.boolean "deceased"
    t.boolean "inactive"
    t.string "inactive_description"
    t.string "dwelling"
    t.integer "current_camp_id"
    t.integer "previous_camp_id"
    t.string "first_name"
    t.string "last_name"
    t.string "status"
    t.string "gender"
    t.date "last_interaction_date"
    t.string "admin_notes"
    t.integer "number_tanks"
    t.integer "number_hoses"
    t.integer "household_id"
    t.boolean "first_time_homeless"
    t.date "date_became_homeless"
    t.string "homeless_reason"
    t.boolean "due_to_covid"
    t.index ["first_name", "last_name"], name: "index_clients_on_first_name_and_last_name", unique: true
  end

  create_table "goals_and_next_steps", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "description"
    t.boolean "is_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "health_concerns", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heater_statuses", id: :serial, force: :cascade do |t|
    t.string "status_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heater_types", id: :serial, force: :cascade do |t|
    t.string "type_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "heaters", id: :serial, force: :cascade do |t|
    t.integer "heater_type_id"
    t.string "serial_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "heater_status_id"
    t.string "status_reason"
    t.boolean "is_active"
    t.integer "current_client_id"
  end

  create_table "location_camp_notes", force: :cascade do |t|
    t.integer "location_camp_id"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "location_camps", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "route_id"
    t.integer "position"
    t.string "notes"
    t.decimal "longitude"
    t.decimal "latitude"
    t.string "expected_arrival_time"
    t.string "admin_notes"
    t.decimal "parking_latitude"
    t.decimal "parking_longitude"
    t.boolean "remain_on_route"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.integer "route_id"
    t.string "name"
    t.integer "position"
    t.string "notes"
    t.decimal "longitude"
    t.decimal "latitude"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pass_tokens", id: :serial, force: :cascade do |t|
    t.string "admin_password"
    t.string "regular_password"
    t.string "api_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "volunteer_password"
  end

  create_table "prayer_request_and_needs", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "detail"
    t.boolean "is_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requested_items", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "item_description"
    t.date "date_requested"
    t.boolean "has_received"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "fulfilled"
  end

  create_table "route_instance_heater_interactions", id: :serial, force: :cascade do |t|
    t.integer "route_instance_id"
    t.boolean "is_checked_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "heater_id"
  end

  create_table "route_instance_tank_hose_interactions", id: :serial, force: :cascade do |t|
    t.integer "route_instance_id"
    t.integer "number_hoses_out"
    t.integer "number_hoses_in"
    t.integer "number_tanks_out"
    t.integer "number_tanks_in"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_heaters_out"
    t.integer "number_heaters_in"
  end

  create_table "route_instances", id: :serial, force: :cascade do |t|
    t.integer "route_id"
    t.string "leader_name"
    t.string "leader_phone"
    t.boolean "heat_route"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_route_members"
    t.string "scribe_name"
    t.string "scribe_phone"
  end

  create_table "routes", id: :serial, force: :cascade do |t|
    t.string "region"
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_aftercare"
    t.string "admin_notes"
  end

  create_table "tanks", id: :serial, force: :cascade do |t|
    t.string "serial_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_token"
    t.string "password_digest"
  end

  create_table "volunteers", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
