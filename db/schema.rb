# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_11_194723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battle_results", force: :cascade do |t|
    t.integer "tank_id"
    t.integer "experience"
    t.integer "damage"
    t.integer "assist"
    t.integer "block"
    t.integer "medal"
    t.integer "source", default: 0, null: false
    t.string "external_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "win", default: false
    t.index ["tank_id"], name: "index_battle_results_on_tank_id"
  end

  create_table "countries", force: :cascade do |t|
    t.jsonb "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tank_externals", force: :cascade do |t|
    t.integer "tank_id"
    t.integer "source", default: 0, null: false
    t.string "external_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tank_id"], name: "index_tank_externals_on_tank_id"
  end

  create_table "tanks", force: :cascade do |t|
    t.jsonb "name"
    t.integer "tier", default: 1, null: false
    t.integer "type", default: 0, null: false
    t.integer "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "health"
    t.integer "damage_per_shot"
    t.index ["country_id"], name: "index_tanks_on_country_id"
  end

end
