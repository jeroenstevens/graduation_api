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

ActiveRecord::Schema.define(version: 20141101135349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "api_keys", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid     "user_id"
    t.string   "access_token"
    t.string   "scope"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "last_access"
    t.boolean  "is_locked",    default: false
  end

  add_index "api_keys", ["access_token"], name: "index_api_keys_on_access_token", unique: true, using: :btree

  create_table "collections", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "collections", ["name"], name: "index_collections_on_name", using: :btree
  add_index "collections", ["user_id"], name: "index_collections_on_user_id", using: :btree

  create_table "items", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "collection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["collection_id"], name: "index_items_on_collection_id", using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["tag_id"], name: "index_tags_on_tag_id", using: :btree
  add_index "tags", ["user_id"], name: "index_tags_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
