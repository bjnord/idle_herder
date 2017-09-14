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

ActiveRecord::Schema.define(version: 20170914111549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_heroes", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "hero_id"
    t.bigint "shard_type_id"
    t.integer "level", default: 1, null: false
    t.integer "shards", default: 0, null: false
    t.integer "priority", default: 1, null: false
    t.boolean "is_fodder"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_account_heroes_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "player_name", null: false
    t.string "server"
    t.string "guild_name"
    t.integer "level"
    t.text "description"
    t.integer "icon_hero_id"
    t.string "player_id"
    t.string "vip_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "player_name"], name: "index_accounts_on_user_id_and_player_name"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "heroes", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.integer "stars", null: false
    t.string "role", null: false
    t.integer "power"
    t.string "image_file"
    t.integer "health"
    t.integer "attack"
    t.integer "armor"
    t.integer "speed"
    t.string "wiki_url"
    t.boolean "natural", default: false, null: false
    t.integer "faction", null: false
    t.index ["id"], name: "index_heroes_on_id", unique: true
    t.index ["name", "stars"], name: "index_heroes_on_name_and_stars", unique: true
    t.index ["stars", "faction", "name"], name: "index_heroes_on_stars_and_faction_and_name"
  end

  create_table "materials", force: :cascade do |t|
    t.bigint "hero_id", null: false
    t.integer "count", null: false
    t.bigint "material_hero_id"
    t.integer "stars"
    t.integer "faction"
    t.index ["hero_id"], name: "index_materials_on_hero_id"
    t.index ["material_hero_id"], name: "index_materials_on_material_hero_id"
  end

  create_table "shard_types", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.integer "stars", null: false
    t.integer "faction"
    t.string "image_file"
    t.index ["id"], name: "index_shard_types_on_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
