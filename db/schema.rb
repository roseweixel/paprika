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

ActiveRecord::Schema.define(version: 20141205015217) do

  create_table "articles", force: true do |t|
    t.string   "name"
    t.integer  "story_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url"
    t.string   "abstract"
    t.integer  "rank"
    t.date     "published_date"
  end

  add_index "articles", ["day_id"], name: "index_articles_on_day_id"
  add_index "articles", ["story_id"], name: "index_articles_on_story_id"

  create_table "days", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "popularity_score"
    t.integer  "story_id"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
