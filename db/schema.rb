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

ActiveRecord::Schema.define(version: 20160405135947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.string   "home_team_name"
    t.integer  "home_team_id"
    t.string   "away_team_name"
    t.integer  "away_team_id"
    t.string   "venue_name"
    t.integer  "venue_id"
    t.datetime "time"
    t.string   "round"
    t.string   "home_q1"
    t.string   "away_q1"
    t.string   "home_q2"
    t.string   "away_q2"
    t.string   "home_q3"
    t.string   "away_q3"
    t.string   "home_q4"
    t.string   "away_q4"
    t.integer  "home_score"
    t.integer  "away_score"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.string   "nickname",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
