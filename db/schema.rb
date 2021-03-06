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

ActiveRecord::Schema.define(version: 2021_02_16_204726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id", null: false
    t.boolean "not_rewinded"
    t.bigint "title_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["title_id"], name: "index_rentals_on_title_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "genre_id", null: false
    t.integer "release_year"
    t.integer "rate_per_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "imdb_id"
    t.index ["genre_id"], name: "index_titles_on_genre_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "maximum_rentals"
    t.string "firstname"
    t.string "lastname"
    t.string "address1"
    t.string "address2"
    t.string "postcode"
    t.string "phonenumber"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "rentals", "titles"
  add_foreign_key "rentals", "users"
  add_foreign_key "titles", "genres"
end
