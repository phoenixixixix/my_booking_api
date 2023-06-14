# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_14_152411) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country", null: false
    t.string "city", null: false
    t.string "street", null: false
    t.string "phone_number", null: false
    t.bigint "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_addresses_on_property_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assets_properties", id: false, force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.bigint "property_id", null: false
    t.index ["asset_id"], name: "index_assets_properties_on_asset_id"
    t.index ["property_id"], name: "index_assets_properties_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "title", null: false
    t.string "placement_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "properties"
end
