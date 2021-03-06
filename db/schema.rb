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

ActiveRecord::Schema.define(version: 20160501032628) do

  create_table "code_climate_metrics", force: :cascade do |t|
    t.float    "score"
    t.float    "gpa"
    t.integer  "coverage"
    t.string   "url"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "code_climate_metrics", ["project_id"], name: "index_code_climate_metrics_on_project_id"

  create_table "pivotal_trackers", force: :cascade do |t|
    t.integer  "done"
    t.integer  "new"
    t.integer  "old"
    t.integer  "older"
    t.integer  "tracker_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "total"
    t.float    "score"
  end

  add_index "pivotal_trackers", ["project_id"], name: "index_pivotal_trackers_on_project_id"

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer  "red"
    t.integer  "yellow"
    t.integer  "green"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "repo"
    t.integer  "total"
    t.float    "score"
  end

  add_index "pull_requests", ["project_id"], name: "index_pull_requests_on_project_id"

  create_table "slack_data_points", force: :cascade do |t|
    t.string   "user"
    t.integer  "messages"
    t.integer  "slack_metric_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "slack_data_points", ["slack_metric_id"], name: "index_slack_data_points_on_slack_metric_id"

  create_table "slack_metrics", force: :cascade do |t|
    t.string   "slack_api_token"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "slack_metrics", ["project_id"], name: "index_slack_metrics_on_project_id"

  create_table "slack_trends", force: :cascade do |t|
    t.integer  "weekone"
    t.integer  "weektwo"
    t.integer  "weekthree"
    t.integer  "project_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "slack_api_token"
  end

  add_index "slack_trends", ["project_id"], name: "index_slack_trends_on_project_id"

end
