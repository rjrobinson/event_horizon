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

ActiveRecord::Schema.define(version: 20140706183730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "submission_id", null: false
    t.text     "body",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["submission_id"], name: "index_comments_on_submission_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "submissions", force: true do |t|
    t.integer  "user_id",       null: false
    t.integer  "assignment_id", null: false
    t.text     "body",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "submissions", ["assignment_id"], name: "index_submissions_on_assignment_id", using: :btree
  add_index "submissions", ["user_id"], name: "index_submissions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "uid",                           null: false
    t.string   "provider",                      null: false
    t.string   "email",                         null: false
    t.string   "username",                      null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",       default: "member", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
