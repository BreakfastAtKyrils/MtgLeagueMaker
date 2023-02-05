ActiveRecord::Schema[7.0].define do
  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "decks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "played_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_records", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "deck_id", null: false
    t.string "record_type", null: false
    t.integer "game_i", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end