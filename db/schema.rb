# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_20_164425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airplains", force: :cascade do |t|
    t.string "model"
    t.integer "first_class", null: false
    t.integer "executive_class", null: false
    t.integer "economic_class", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flight_executions", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.string "status", default: "scheduled"
    t.boolean "delayed", default: false
    t.boolean "canceled", default: false
    t.datetime "departure"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_id"], name: "index_flight_executions_on_flight_id"
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "airplain_id"
    t.string "origin"
    t.integer "duration"
    t.time "time"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "destination"
    t.index ["airplain_id"], name: "index_flights_on_airplain_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "flight_id"
    t.string "email"
    t.string "full_name"
    t.string "national_id"
    t.string "telephone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_id"], name: "index_passengers_on_flight_id"
    t.index ["user_id"], name: "index_passengers_on_user_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "flight_id"
    t.bigint "passenger_id"
    t.string "seat_class", null: false
    t.boolean "near_exit", default: false
    t.boolean "extra_leg_space", default: false
    t.boolean "window_seat", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["flight_id"], name: "index_seats_on_flight_id"
    t.index ["passenger_id"], name: "index_seats_on_passenger_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "flight_executions", "flights"
  add_foreign_key "flights", "airplains"
  add_foreign_key "passengers", "flights"
  add_foreign_key "passengers", "users"
  add_foreign_key "seats", "flights"
  add_foreign_key "seats", "passengers"
end
