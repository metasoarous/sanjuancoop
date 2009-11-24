# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091121023454) do

  create_table "barter_board_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "barter_board_entries", :force => true do |t|
    t.integer  "wanted_category_id"
    t.integer  "offered_category_id"
    t.string   "wanted"
    t.string   "offered"
    t.text     "details"
    t.string   "contact_info"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "board_members", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.text     "description"
    t.string   "image_url"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_items", :force => true do |t|
    t.string   "tag"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "distributors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "description"
    t.text     "details"
    t.date     "date"
    t.time     "time"
    t.integer  "event_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.string   "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_category_subscriptions", :force => true do |t|
    t.integer  "member_id"
    t.integer  "forum_category_id"
    t.string   "frequency"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_posts", :force => true do |t|
    t.text     "body"
    t.integer  "forum_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "member_id"
  end

  create_table "forum_topic_subscriptions", :force => true do |t|
    t.integer  "member_id"
    t.integer  "forum_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", :force => true do |t|
    t.string   "subject"
    t.integer  "forum_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.boolean  "accepts_newsletters"
  end

  add_index "members", ["login"], :name => "index_members_on_login", :unique => true

  create_table "members_product_requests", :force => true do |t|
    t.string   "description"
    t.integer  "member_id"
    t.integer  "product_request_id"
    t.boolean  "ordered"
    t.boolean  "failed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "accepts_newsletters"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletters", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "mail"
    t.text     "delivered"
    t.string   "next_delivery"
  end

  create_table "product_request_statuses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_requests", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_number"
    t.integer  "distributor_id"
    t.integer  "product_request_status_id"
  end

  create_table "volunteer_offerings", :force => true do |t|
    t.integer  "member_id"
    t.integer  "volunteer_task_id"
    t.string   "alt_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteer_tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

end
