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

ActiveRecord::Schema.define(version: 20180112202751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "fuzzystrmatch"
  enable_extension "pg_trgm"

  create_table "animal_medicines", force: :cascade do |t|
    t.bigint "animal_id"
    t.bigint "medicine_id"
    t.integer "recommended_num_of_units"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_animal_medicines_on_animal_id"
    t.index ["medicine_id"], name: "index_animal_medicines_on_medicine_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dosages", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "medicine_id"
    t.integer "units_given"
    t.float "discount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_dosages_on_medicine_id"
    t.index ["visit_id"], name: "index_dosages_on_visit_id"
  end

  create_table "medicine_costs", force: :cascade do |t|
    t.bigint "medicine_id"
    t.integer "cost_per_unit"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_medicine_costs_on_medicine_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "stock_amount"
    t.string "admin_method"
    t.string "unit"
    t.boolean "vaccine"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "notable_type"
    t.integer "notable_id"
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "written_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "email"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.bigint "animal_id"
    t.bigint "owner_id"
    t.boolean "female"
    t.date "date_of_birth"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_pets_on_animal_id"
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  create_table "procedure_costs", force: :cascade do |t|
    t.bigint "procedure_id"
    t.integer "cost"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procedure_id"], name: "index_procedure_costs_on_procedure_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "length_of_time"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatments", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "procedure_id"
    t.boolean "successful"
    t.float "discount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procedure_id"], name: "index_treatments_on_procedure_id"
    t.index ["visit_id"], name: "index_treatments_on_visit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "username"
    t.string "password_digest"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "pet_id"
    t.date "date"
    t.float "weight"
    t.boolean "overnight_stay"
    t.integer "total_charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_visits_on_pet_id"
  end

  add_foreign_key "animal_medicines", "animals"
  add_foreign_key "animal_medicines", "medicines"
  add_foreign_key "dosages", "medicines"
  add_foreign_key "dosages", "visits"
  add_foreign_key "medicine_costs", "medicines"
  add_foreign_key "notes", "users"
  add_foreign_key "pets", "animals"
  add_foreign_key "pets", "owners"
  add_foreign_key "procedure_costs", "procedures"
  add_foreign_key "treatments", "procedures"
  add_foreign_key "treatments", "visits"
  add_foreign_key "visits", "pets"
end
