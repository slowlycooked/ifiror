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

ActiveRecord::Schema.define(version: 20160504062052) do

  create_table "books", force: :cascade do |t|
    t.string   "book_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "tenant_id",  limit: 4
  end

  create_table "customers", force: :cascade do |t|
    t.string   "cname",      limit: 255, null: false
    t.string   "phone_no",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "tenant_id",  limit: 4
  end

  create_table "fee_records", force: :cascade do |t|
    t.float    "credit",     limit: 24
    t.float    "debit",      limit: 24
    t.integer  "fee_id",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "comment",    limit: 65535
  end

  add_index "fee_records", ["fee_id"], name: "index_fee_records_on_fee_id", using: :btree

  create_table "fees", force: :cascade do |t|
    t.string   "fee_name",   limit: 255
    t.integer  "book_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "fees", ["book_id"], name: "index_fees_on_book_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.float    "debit",       limit: 24
    t.float    "credit",      limit: 24
    t.float    "bad",         limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "tenant_id",   limit: 4
  end

  add_index "records", ["customer_id"], name: "index_records_on_customer_id", using: :btree

  create_table "tenants", force: :cascade do |t|
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
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "mobile",                 limit: 255,              null: false
    t.string   "invitation",             limit: 255
  end

  add_index "tenants", ["email"], name: "index_tenants_on_email", unique: true, using: :btree
  add_index "tenants", ["reset_password_token"], name: "index_tenants_on_reset_password_token", unique: true, using: :btree
  add_index "tenants", ["unlock_token"], name: "index_tenants_on_unlock_token", unique: true, using: :btree

  add_foreign_key "fee_records", "fees"
  add_foreign_key "fees", "books"
  add_foreign_key "records", "customers"
end
