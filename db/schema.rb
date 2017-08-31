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

ActiveRecord::Schema.define(version: 20170831180632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "heroes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.integer "stars", null: false
    t.string "faction", null: false
    t.string "role", null: false
    t.integer "power"
    t.string "image_file"
    t.integer "health"
    t.integer "attack"
    t.integer "armor"
    t.integer "speed"
    t.index ["id"], name: "index_heroes_on_id", unique: true
    t.index ["name", "stars"], name: "index_heroes_on_name_and_stars", unique: true
  end

  create_table "materials", force: :cascade do |t|
    t.bigint "hero_id", null: false
    t.integer "count", null: false
    t.bigint "material_hero_id"
    t.integer "stars"
    t.string "faction"
    t.index ["hero_id"], name: "index_materials_on_hero_id"
  end

end
