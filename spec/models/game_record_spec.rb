require 'rails_helper'

RSpec.describe GameRecord do
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

  describe '#player_id' do
    let(:game_record) { described_class.first }

    it 'is required by the model' do
      subject.player_id = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.player_id = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'is the correct player' do
      player = Player.find(game_record.player_id)

      expect(player.name).to eq 'Kyril'
    end
  end

  describe '#game_id' do
    let(:game_record) { described_class.first }

    it 'is required by the model' do
      subject.game_id = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.game_id = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'is the correct game' do
      game = Game.find(game_record.game_id)

      expect(game.id).to eq 1
    end
  end

  describe '#record_type' do
    let(:game_record) { described_class.first }

    it 'is required by the model' do
      subject.record_type = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.record_type = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'is the correct record' do
      record = game_record.record_type

      expect(record).to eq 'WIN'
    end
  end

  describe '#deck_id' do
    let(:game_record) { described_class.first }

    it 'is required by the model' do
      subject.deck_id = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.deck_id = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'is the correct deck' do
      deck = Deck.find(game_record.deck_id)

      expect(deck.name).to eq 'Tivit'
    end
  end
end
