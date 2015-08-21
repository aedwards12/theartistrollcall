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

ActiveRecord::Schema.define(version: 20150812213622) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "url",        null: false
  end

  add_index "api_requests", ["url"], name: "index_api_requests_on_url", unique: true, using: :btree

  create_table "artist_videos", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "video_id"
    t.string   "artist_role"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "twitter_screen_name"
    t.string   "twitter_img_url"
    t.string   "twitter_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "yt_count",       default: "no data available", null: false
    t.string   "yt_title",       default: "no data available", null: false
    t.string   "yt_description", default: "no data available", null: false
    t.string   "yt_author",      default: "no data available", null: false
    t.string   "yt_pub_date",    default: "no data available", null: false
  end

end
