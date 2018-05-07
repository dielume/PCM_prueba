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

ActiveRecord::Schema.define(version: 20180507110813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "food_orders", force: :cascade do |t|
    t.bigint "food_id"
    t.bigint "order_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["food_id"], name: "index_food_orders_on_food_id"
    t.index ["order_id"], name: "index_food_orders_on_order_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "table"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "food_orders", "foods"
  add_foreign_key "food_orders", "orders"
end
