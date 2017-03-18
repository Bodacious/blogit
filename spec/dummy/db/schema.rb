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

ActiveRecord::Schema.define(version: 20150705003228) do

  create_table "blogit_comments", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "website"
    t.text "body", null: false
    t.integer "post_id", null: false
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_blogit_comments_on_post_id"
  end

  create_table "blogit_posts", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "state", default: "draft", null: false
    t.integer "comments_count", default: 0, null: false
    t.string "blogger_type"
    t.integer "blogger_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.index ["blogger_type", "blogger_id"], name: "index_blogit_posts_on_blogger_type_and_blogger_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
