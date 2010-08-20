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

ActiveRecord::Schema.define(:version => 20100625071920) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "filter"
    t.string   "city"  
    t.integer  "vendors_count"
    t.integer  "order" 
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer "count"
    t.string  "category"
    t.integer "vendor_id"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "address"
    t.string   "phone"
    t.string   "work_time"
    t.string   "traffic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tags"
    t.integer  "sum"
    t.integer  "env"
    t.integer  "taste"
    t.integer  "avg"
    t.integer  "service"
    t.string   "category"
    t.string   "city"  
    t.string   'area'
    t.float    'lng'
    t.float    'lat'  
    t.float    "discount",:default => 10  
    t.float    "customer_discount",:default => 0
    t.float    "system_discount",:default => 0  
    t.integer  "bookings_count", :default => 0
  end    
  
  create_table "bookings" do |t|
    t.integer  "vendor_id" 
    t.float    "customer_discount" ,:default => 0    
    t.float    "system_discount",:default => 0 
    t.datetime "date"
    t.integer  "time_range"
    t.integer  "guest_count"
    t.string   "requirment"
    t.integer  "bookable_id"
    t.string   "bookable_type"
    t.string   "contact"
    t.string   "email"
    t.string   "mobile"
    t.string   "status"
    t.integer  'paid',:default => 0
    t.timestamps
  end      
  
  create_table "bills" do |t|
    t.integer  "billable_id"
    t.string   "billable_type"
    t.integer  'paid',:default => 0
    t.timestamps
  end      
  
  create_table "users", :force => true do |t| 
    t.string "login"
    t.string "mobile"   
    t.integer "bookings_count"
    t.string "email",:limit => 100
    t.string "crypted_password", :limit => 40 
    t.string "salt", :limit => 40 
    t.string "remember_token", :limit => 40
    t.datetime "remember_token_expires_at"  
  end    
  
  add_index :users, :mobile, :unique => true
    
  create_table "locations", :force => true do |t|
    t.integer :user_id
    t.string  :name 
    t.integer :order
  end
  
  add_index :locations, :user_id  

end
