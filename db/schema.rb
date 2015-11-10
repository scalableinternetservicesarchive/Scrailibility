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

ActiveRecord::Schema.define(version: 20151105100849) do

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id",        limit: 4
    t.integer  "recipient_id",     limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "sender_unread",    limit: 4,   default: 0
    t.integer  "recipient_unread", limit: 4,   default: 0
    t.string   "last_message",     limit: 255
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "body",            limit: 255
    t.integer  "conversation_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "nick_name",          limit: 255
    t.decimal  "age",                            precision: 4
    t.decimal  "height",                         precision: 4
    t.decimal  "weight",                         precision: 4
    t.string   "add1",               limit: 255
    t.string   "add2",               limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "country",            limit: 255
    t.integer  "post_code",          limit: 4
    t.float    "latitude",           limit: 24
    t.float    "longitude",          limit: 24
    t.datetime "birthday"
    t.string   "birthyear",          limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "user_id",            limit: 4
    t.string   "photo_file_name",    limit: 255
    t.string   "photo_content_type", limit: 255
    t.integer  "photo_file_size",    limit: 4
    t.datetime "photo_updated_at"
  end

  create_table "timeslots", force: :cascade do |t|
    t.time     "begintime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_timeslots", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "timeslot_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "user_timeslots", ["timeslot_id"], name: "fk_rails_1104225855", using: :btree
  add_index "user_timeslots", ["user_id"], name: "fk_rails_9dcc964397", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "user_timeslots", "timeslots"
  add_foreign_key "user_timeslots", "users"
end
