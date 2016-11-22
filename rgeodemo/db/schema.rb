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

ActiveRecord::Schema.define(version: 20161028035001) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "life_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string    "name"
    t.datetime  "created_at",                                                          null: false
    t.datetime  "updated_at",                                                          null: false
    t.geography "latlon",     limit: {:srid=>4326, :type=>"point", :geographic=>true}
  end

  create_table "medicinal_plants", force: :cascade do |t|
    t.string   "name"
    t.string   "scientific_name"
    t.text     "description"
    t.integer  "plant_class_id"
    t.integer  "plant_phylum_id"
    t.integer  "plant_order_id"
    t.integer  "plant_kingdom_id"
    t.integer  "life_type_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "plant_avatar"
    t.json     "plant_images"
  end

  create_table "medicinal_plants_locations", force: :cascade do |t|
    t.integer  "medicinal_plant_id"
    t.integer  "location_id"
    t.integer  "quantity"
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "medicinal_plants_plant_habitats", force: :cascade do |t|
    t.integer  "medicinal_plant_id"
    t.integer  "plant_habitat_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "medicinal_plants_used_parts", force: :cascade do |t|
    t.integer  "medicinal_plant_id"
    t.integer  "used_part_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "plant_classes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "plant_habitats", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "plant_kingdoms", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "plant_orders", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "plant_phylums", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "used_parts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "medicinal_plants_locations", "locations"
  add_foreign_key "medicinal_plants_locations", "medicinal_plants"
  add_foreign_key "medicinal_plants_plant_habitats", "medicinal_plants"
  add_foreign_key "medicinal_plants_plant_habitats", "plant_habitats"
  add_foreign_key "medicinal_plants_used_parts", "medicinal_plants"
  add_foreign_key "medicinal_plants_used_parts", "used_parts"
end
