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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101020152206) do

  create_table "board_members", :force => true do |t|
    t.string    "name"
    t.string    "role"
    t.text      "description"
    t.string    "image_url"
    t.boolean   "active"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "content_items", :force => true do |t|
    t.string    "tag"
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "distributors", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "address"
    t.string    "website"
  end

  create_table "event_categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string    "description"
    t.text      "details"
    t.date      "date"
    t.time      "time"
    t.integer   "event_category_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.string    "question"
    t.text      "answer"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "forum_categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "forum_category_subscriptions", :force => true do |t|
    t.integer  "user_id"
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
    t.integer  "user_id"
  end

  create_table "forum_topic_subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "forum_topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_topics", :force => true do |t|
    t.string    "subject"
    t.integer   "forum_category_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "email"
    t.boolean   "accepts_newsletters"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "newsletters", :force => true do |t|
    t.string    "subject"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "mail"
    t.text      "delivered"
    t.string    "next_delivery"
  end

  create_table "product_request_statuses", :force => true do |t|
    t.string    "name"
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "product_requests", :force => true do |t|
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "product_number"
    t.integer   "distributor_id"
    t.integer   "product_request_status_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                         :limit => 40
    t.string   "email",                         :limit => 100
    t.string   "crypted_password",              :limit => 128, :default => "",        :null => false
    t.string   "password_salt",                 :limit => 128, :default => "",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "old_remember_token",            :limit => 40
    t.datetime "old_remember_token_expires_at"
    t.string   "old_activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                        :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.boolean  "accepts_newsletters"
    t.integer  "login_count",                                  :default => 0,         :null => false
    t.integer  "failed_login_count",                           :default => 0,         :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.boolean  "active",                                       :default => false,     :null => false
  end

  add_index "users", ["login"], :name => "index_members_on_login", :unique => true
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "users_product_requests", :force => true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.integer  "product_request_id"
    t.boolean  "ordered"
    t.boolean  "failed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteer_offerings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "volunteer_task_id"
    t.string   "alt_contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "volunteer_tasks", :force => true do |t|
    t.string    "name"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "order"
  end

end
