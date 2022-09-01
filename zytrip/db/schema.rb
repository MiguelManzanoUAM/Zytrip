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

ActiveRecord::Schema[7.0].define(version: 2022_08_31_100140) do
  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "logo"
    t.string "phone_number"
    t.text "description"
  end

  create_table "companies", force: :cascade do |t|
    t.boolean "family", default: false
    t.boolean "romantic", default: false
    t.boolean "friends", default: false
    t.boolean "alone", default: false
    t.boolean "people", default: false
    t.integer "preference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preference_id"], name: "index_companies_on_preference_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.integer "trip_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "destination", default: 0
    t.integer "budget", default: 0
    t.integer "duration", default: 0
    t.index ["trip_id"], name: "index_preferences_on_trip_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.decimal "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "trip_id"
    t.index ["trip_id"], name: "index_reviews_on_trip_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.boolean "lodging", default: false
    t.boolean "gastronomy", default: false
    t.boolean "activities", default: false
    t.integer "preference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preference_id"], name: "index_services_on_preference_id"
  end

  create_table "topics", force: :cascade do |t|
    t.boolean "beach", default: false
    t.boolean "nature", default: false
    t.boolean "tourism", default: false
    t.integer "preference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preference_id"], name: "index_topics_on_preference_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "agency_id"
    t.decimal "price", default: "0.0"
    t.decimal "rating", default: "0.0"
    t.string "image"
    t.string "country"
    t.string "city"
    t.string "description"
    t.index ["agency_id"], name: "index_trips_on_agency_id"
  end

  create_table "trips_users", id: false, force: :cascade do |t|
    t.integer "trip_id", null: false
    t.integer "user_id", null: false
    t.index ["trip_id"], name: "index_trips_users_on_trip_id"
    t.index ["user_id"], name: "index_trips_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "name"
    t.string "surname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies", "preferences"
  add_foreign_key "preferences", "trips"
  add_foreign_key "reviews", "trips"
  add_foreign_key "reviews", "users"
  add_foreign_key "services", "preferences"
  add_foreign_key "topics", "preferences"
  add_foreign_key "trips", "agencies"
end
