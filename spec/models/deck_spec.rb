require 'rails_helper'

RSpec.describe Deck do
  def seed_db
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
  end

  before do
    seed_db
  end

  describe '#name' do
    let(:player) { Player.find_by(name: 'Pavle') }
    let(:deck) { described_class.find_by(player: player) }

    it 'is required by the model' do
      subject.name = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.name = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'is the correct name for a given deck' do
      expected_name = 'Omnath'
      expect(deck.name).to eq expected_name
    end
  end
end
