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

ActiveRecord::Schema.define(version: 2020_04_07_191005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "calls", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_calls_on_contact_id"
    t.index ["user_id"], name: "index_calls_on_user_id"
  end

  create_table "consultation_symptom", force: :cascade do |t|
    t.bigint "consultations_id"
    t.bigint "symptoms_id"
    t.index ["consultations_id"], name: "index_consultation_symptom_on_consultations_id"
    t.index ["symptoms_id"], name: "index_consultation_symptom_on_symptoms_id"
  end

  create_table "consultation_types", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.text "reason_for_calling"
    t.text "other_details"
    t.string "current_status"
    t.string "category"
    t.boolean "antenatal", default: false
    t.boolean "quarantined", default: false
    t.date "quarantined_on"
    t.boolean "endemic", default: false
    t.integer "family_members_count"
    t.integer "elderly"
    t.integer "comorbidities"
    t.boolean "prescription_given"
    t.text "notes"
    t.string "tested"
    t.date "sample_taken_on"
    t.bigint "actions_id"
    t.string "shift_from"
    t.string "shift_to"
    t.string "reason"
    t.string "string"
    t.date "surveillance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["actions_id"], name: "index_consultations_on_actions_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "gender"
    t.integer "age"
    t.string "house_name"
    t.integer "ward"
    t.string "landmark"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "panchayat_id"
    t.string "alternate_contact"
    t.string "nerby_phc"
    t.string "health_worker"
    t.string "number_health_worker"
    t.text "description"
    t.string "status"
    t.date "dob"
    t.string "old_case_id"
    t.bigint "consultation_type_id"
    t.bigint "source_id"
    t.bigint "assigned_to_id"
    t.index ["assigned_to_id"], name: "index_contacts_on_assigned_to_id"
    t.index ["consultation_type_id"], name: "index_contacts_on_consultation_type_id"
    t.index ["panchayat_id"], name: "index_contacts_on_panchayat_id"
    t.index ["phone"], name: "index_contacts_on_phone", unique: true
    t.index ["source_id"], name: "index_contacts_on_source_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.bigint "users_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_id"], name: "index_doctors_on_users_id"
  end

  create_table "medical_reqs", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.boolean "need_medicines"
    t.boolean "fullfilled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "requirement_type"
    t.string "other_needs"
    t.string "not_able_type"
    t.index ["contact_id"], name: "index_medical_reqs_on_contact_id"
  end

  create_table "non_medical_reqs", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.boolean "need_food"
    t.boolean "fullfilled"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "requirement_type"
    t.string "other_needs"
    t.string "not_able_type"
    t.index ["contact_id"], name: "index_non_medical_reqs_on_contact_id"
  end

  create_table "panchayats", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "symptoms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.bigint "panchayat_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["panchayat_id"], name: "index_users_on_panchayat_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "calls", "contacts"
  add_foreign_key "calls", "users"
  add_foreign_key "doctors", "users", column: "users_id"
  add_foreign_key "medical_reqs", "contacts"
  add_foreign_key "non_medical_reqs", "contacts"
end
