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

ActiveRecord::Schema.define(version: 20150617135341) do

  create_table "answers", force: :cascade do |t|
    t.string   "answer"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "answers", ["assignment_id"], name: "index_answers_on_assignment_id"

  create_table "assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "homework_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignments", ["homework_id"], name: "index_assignments_on_homework_id"
  add_index "assignments", ["user_id"], name: "index_assignments_on_user_id"

  create_table "homeworks", force: :cascade do |t|
    t.string   "title"
    t.string   "question"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",   null: false
    t.integer  "role",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
