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

ActiveRecord::Schema.define(version: 20160204060600) do

  create_table "customers", force: :cascade do |t|
    t.string   "cname",      limit: 255, null: false
    t.string   "phone_no",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "fee_records", force: :cascade do |t|
    t.float    "credit",     limit: 24
    t.float    "debit",      limit: 24
    t.integer  "fee_id",     limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "fee_records", ["fee_id"], name: "index_fee_records_on_fee_id", using: :btree

  create_table "fees", force: :cascade do |t|
    t.string   "fee_name",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.integer  "book_id",     limit: 4
    t.float    "debit",       limit: 24
    t.float    "credit",      limit: 24
    t.float    "bad",         limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "records", ["customer_id"], name: "index_records_on_customer_id", using: :btree

  add_foreign_key "fee_records", "fees"
  add_foreign_key "records", "customers"
end
