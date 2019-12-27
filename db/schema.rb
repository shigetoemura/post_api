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

ActiveRecord::Schema.define(version: 2019_11_05_093731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "group_member_id"
    t.bigint "opponent_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favorable_type"
    t.bigint "favorable_id"
    t.bigint "group_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_post_id"
  end

  create_table "gestusers", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_answer_favirites_counts", force: :cascade do |t|
    t.bigint "group_answer_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_answer_reports", force: :cascade do |t|
    t.bigint "group_answer_id"
    t.bigint "group_member_id"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_answers", force: :cascade do |t|
    t.bigint "group_member_id"
    t.bigint "reply_to_id"
    t.string "text"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_question_id"
  end

  create_table "group_member_counts", force: :cascade do |t|
    t.integer "group_id"
    t.bigint "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_member_infos", force: :cascade do |t|
    t.bigint "group_member_id"
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_member_id"], name: "index_group_member_infos_on_group_member_id"
  end

  create_table "group_member_reports", force: :cascade do |t|
    t.bigint "group_member_id"
    t.string "reason"
    t.bigint "reported_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "group_post_favirites_counts", force: :cascade do |t|
    t.integer "count"
    t.bigint "group_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_post_reply_counts", force: :cascade do |t|
    t.bigint "group_post_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_post_reports", force: :cascade do |t|
    t.bigint "group_post_id"
    t.bigint "group_member_id"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_posts", force: :cascade do |t|
    t.bigint "group_member_id"
    t.bigint "group_id"
    t.string "text"
    t.string "icon"
    t.bigint "reply_to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_question_answer_member_counts", force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_question_id"
  end

  create_table "group_questions", force: :cascade do |t|
    t.bigint "group_member_id"
    t.bigint "group_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "icon"
    t.string "title"
    t.string "info"
    t.string "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "icon"
    t.string "text"
    t.bigint "group_member_id"
    t.bigint "chat_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "group_member_id"
    t.bigint "from_member_id"
    t.bigint "notificable_type"
    t.bigint "notificable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "group_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_uuid"
  end

  add_foreign_key "group_member_infos", "group_members"
end
