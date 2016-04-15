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

ActiveRecord::Schema.define(version: 20160415004159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_player_stats", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "match_id"
    t.integer  "disposals"
    t.integer  "kicks"
    t.integer  "marks"
    t.integer  "handballs"
    t.integer  "goals"
    t.integer  "behinds"
    t.integer  "hit_outs"
    t.integer  "tackles"
    t.integer  "rebounds"
    t.integer  "inside_50s"
    t.integer  "clearances"
    t.integer  "clangers"
    t.integer  "frees"
    t.integer  "frees_against"
    t.integer  "contested_possessions"
    t.integer  "uncontested_possessions"
    t.integer  "contested_marks"
    t.integer  "marks_inside_50"
    t.integer  "one_percenters"
    t.integer  "bounces"
    t.integer  "goal_assists"
    t.integer  "percent_played"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "year"
    t.string   "round"
    t.datetime "started_at"
    t.string   "home_team_name"
    t.integer  "home_team_id"
    t.string   "away_team_name"
    t.integer  "away_team_id"
    t.string   "venue_name"
    t.integer  "venue_id"
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
    t.integer  "attendance"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "dob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "weight"
    t.integer  "height"
  end

  create_table "team_players", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "jumper"
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "code",          null: false
    t.string   "nickname",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "afltables_url"
    t.boolean  "current"
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
