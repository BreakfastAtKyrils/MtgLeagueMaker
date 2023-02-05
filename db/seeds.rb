# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Player.create([
  { name: 'Karl' },
  { name: 'Jules' },
  { name: 'Pavle' },
  { name: 'Kyril' }
])

Deck.create([
  { name: 'Omnath', player_id: Player.find_by(name: 'Pavle').id },
  { name: 'Tivit', player_id: Player.find_by(name: 'Kyril').id },
  { name: 'Krark', player_id: Player.find_by(name: 'Karl').id },
  { name: 'Osgir', player_id: Player.find_by(name: 'Jules').id }
])

Game.create([
  { played_at: Time.zone.local(2020, 10, 31) }
])

# create_table "game_records", force: :cascade do |t|
#   t.integer "player_id", null: false
#   t.integer "deck_id", null: false
#   t.string "record_type", null: false
#   t.integer "game_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

GameRecord.create([
  {
    player_id: Player.find_by(name: 'Kyril').id,
    deck_id: Deck.find_by(name: 'Tivit').id,
    record_type: 'WIN',
    game_id: Game.first.id
  },
  {
    player_id: Player.find_by(name: 'Pavle').id,
    deck_id: Deck.find_by(name: 'Omnath').id,
    record_type: 'LOSS',
    game_id: Game.first.id
  },
  {
    player_id: Player.find_by(name: 'Karl').id,
    deck_id: Deck.find_by(name: 'Krark').id,
    record_type: 'LOSS',
    game_id: Game.first.id
  },
  {
    player_id: Player.find_by(name: 'Jules').id,
    deck_id: Deck.find_by(name: 'Osgir').id,
    record_type: 'LOSS',
    game_id: Game.first.id
  }
])
