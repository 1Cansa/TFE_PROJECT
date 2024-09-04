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

ActiveRecord::Schema[7.1].define(version: 2024_07_08_125912) do
  create_table "drivers", force: :cascade do |t|
    t.string "name"
    t.string "affiliation"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.float "temperature"
    t.float "quantity"
    t.float "lat"
    t.float "lng"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_logs_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status"
    t.float "shipped_quantity"
    t.float "received_quantity"
    t.integer "truck_id", null: false
    t.integer "user_id", null: false
    t.datetime "shipped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start", default: "-11.57405909955857,27.485894797487294"
    t.string "destination"
    t.index ["truck_id"], name: "index_orders_on_truck_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "trucks", force: :cascade do |t|
    t.string "plate"
    t.float "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_available", default: false
    t.integer "driver_id"
    t.index ["driver_id"], name: "index_trucks_on_driver_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "role", default: "USER", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "logs", "orders"
  add_foreign_key "orders", "trucks"
  add_foreign_key "orders", "users"
  add_foreign_key "trucks", "drivers"
end
