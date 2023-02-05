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
