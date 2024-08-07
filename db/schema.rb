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

ActiveRecord::Schema.define(version: 2024_07_09_192530) do

  create_table "accounts", force: :cascade do |t|
    t.string "google_oauth2", default: "false"
    t.string "github", default: "false"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "bans", force: :cascade do |t|
    t.datetime "start", null: false
    t.datetime "end", null: false
    t.text "reason", null: false
    t.boolean "active", default: true
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bans_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "year", null: false
    t.integer "university_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["university_id"], name: "index_courses_on_university_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "note_id", null: false
    t.boolean "favorite", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id"], name: "index_favorites_on_note_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "note_reports", force: :cascade do |t|
    t.text "report", null: false
    t.string "subject", null: false
    t.integer "note_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id"], name: "index_note_reports_on_note_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title", null: false
    t.string "pdf"
    t.integer "owner_id", null: false
    t.string "tags"
    t.boolean "visibility"
    t.integer "course_id", null: false
    t.integer "university_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "suspended", default: false
    t.index ["course_id"], name: "index_notes_on_course_id"
    t.index ["owner_id"], name: "index_notes_on_owner_id"
    t.index ["university_id"], name: "index_notes_on_university_id"
  end

  create_table "notes_tags", id: false, force: :cascade do |t|
    t.integer "note_id", null: false
    t.integer "tag_id", null: false
    t.index ["tag_id", "note_id"], name: "index_notes_tags_on_tag_id_and_note_id"
  end

  create_table "review_reports", force: :cascade do |t|
    t.text "report", null: false
    t.string "subject", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_review_reports_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.integer "rating", null: false
    t.integer "owner_id", null: false
    t.integer "note_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["note_id"], name: "index_reviews_on_note_id"
    t.index ["owner_id"], name: "index_reviews_on_owner_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "subject", null: false
    t.text "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name", null: false
    t.string "op_name", null: false
    t.string "status", null: false
    t.string "uni_type", null: false
    t.string "address", null: false
    t.string "municipality", null: false
    t.string "url", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_reports", force: :cascade do |t|
    t.text "report", null: false
    t.string "subject", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_reports_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.integer "university_details_id"
    t.integer "account_id"
    t.integer "ban_id"
    t.string "role", default: "user"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "avatar"
    t.boolean "trusted", default: false
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["ban_id"], name: "index_users_on_ban_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["university_details_id"], name: "index_users_on_university_details_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "bans", "users"
  add_foreign_key "courses", "universities"
  add_foreign_key "favorites", "notes"
  add_foreign_key "favorites", "users"
  add_foreign_key "note_reports", "notes"
  add_foreign_key "notes", "courses"
  add_foreign_key "notes", "universities"
  add_foreign_key "notes", "users", column: "owner_id"
  add_foreign_key "review_reports", "reviews"
  add_foreign_key "reviews", "notes"
  add_foreign_key "reviews", "users", column: "owner_id"
  add_foreign_key "tickets", "users"
  add_foreign_key "user_reports", "users"
  add_foreign_key "users", "accounts"
  add_foreign_key "users", "bans"
  add_foreign_key "users", "universities", column: "university_details_id"
end
