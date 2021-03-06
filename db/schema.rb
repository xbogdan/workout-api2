# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160123082651) do

  create_table "exercise_muscle_groups", force: :cascade do |t|
    t.integer  "exercise_id"
    t.integer  "muscle_group_id"
    t.boolean  "primary"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "exercise_muscle_groups", ["exercise_id", "muscle_group_id"], name: "index_exercise_muscle_groups_on_ex_id_and_mg_id", unique: true

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "exercises", ["name"], name: "index_exercises_on_name", unique: true

  create_table "favorite_exercises", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "muscle_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "muscle_group_id"
  end

  add_index "muscle_groups", ["name"], name: "index_muscle_groups_on_name", unique: true

  create_table "program_day_exercise_sets", force: :cascade do |t|
    t.integer  "reps"
    t.integer  "program_day_exercise_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "ord"
  end

  create_table "program_day_exercises", force: :cascade do |t|
    t.integer  "program_day_id"
    t.integer  "exercise_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ord"
  end

  create_table "program_days", force: :cascade do |t|
    t.string   "name"
    t.integer  "program_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "ord"
    t.boolean  "rest_day",   default: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "level"
    t.string   "goal"
    t.boolean  "private",    default: true, null: false
    t.integer  "upvotes",    default: 0,    null: false
    t.integer  "downvotes",  default: 0,    null: false
    t.integer  "user_id",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "track_day_exercise_sets", force: :cascade do |t|
    t.integer  "track_day_exercise_id"
    t.integer  "reps"
    t.float    "weight"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "ord"
  end

  create_table "track_day_exercises", force: :cascade do |t|
    t.integer  "track_day_id"
    t.integer  "exercise_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "ord"
  end

  create_table "track_days", force: :cascade do |t|
    t.integer  "track_id"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "date"
    t.integer  "program_day_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
