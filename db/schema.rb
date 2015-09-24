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

ActiveRecord::Schema.define(version: 20150902065628) do

  create_table "articals", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.text     "images"
    t.integer  "reader_config_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "articals", ["reader_config_id"], name: "index_articals_on_reader_config_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "reader_configs", force: :cascade do |t|
    t.string   "name"
    t.string   "index_url"
    t.integer  "index_pages"
    t.string   "index_artical_link_selector"
    t.string   "index_artical_link_content"
    t.string   "index_next_page_selector"
    t.string   "index_next_page_content"
    t.string   "artical_content_selectors"
    t.string   "artical_img_selectors"
    t.string   "artical_next_page_selector"
    t.string   "artical_next_page_content"
    t.integer  "artical_pages"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "job_id"
    t.integer  "reader_config_id"
    t.integer  "status"
    t.text     "error"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "tasks", ["reader_config_id"], name: "index_tasks_on_reader_config_id"

end
