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

ActiveRecord::Schema.define(version: 20151105230118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_histories", force: :cascade do |t|
    t.text     "description"
    t.integer  "ticket_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ticket_histories", ["ticket_id"], name: "index_ticket_histories_on_ticket_id", using: :btree

  create_table "tickets", force: :cascade do |t|
    t.string   "reference_key"
    t.string   "customer_name"
    t.string   "customer_email"
    t.text     "description"
    t.integer  "department_id"
    t.integer  "subject_id"
    t.integer  "status_id"
    t.integer  "owner_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "tickets", ["department_id"], name: "index_tickets_on_department_id", using: :btree
  add_index "tickets", ["status_id"], name: "index_tickets_on_status_id", using: :btree
  add_index "tickets", ["subject_id"], name: "index_tickets_on_subject_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",          default: "", null: false
    t.string   "second_name",         default: "", null: false
    t.string   "username",            default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "ticket_histories", "tickets"
  add_foreign_key "tickets", "departments"
  add_foreign_key "tickets", "statuses"
  add_foreign_key "tickets", "subjects"
end
