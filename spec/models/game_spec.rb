require 'rails_helper'

RSpec.describe Game do
  describe '#played_at' do
    context 'when absent' do
      let(:game) { build(:game_with_records, played_at: nil) }

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises a database error' do
        expect { game.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game) { build(:game_with_records, played_at: Time.current) }

      it 'is valid' do
        expect(game.valid?).to be true
      end
    end
  end

  describe '#state' do
    context 'when absent' do
      let(:game) { build(:game_with_records, state: nil) }

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises a database error' do
        expect { game.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game) { build(:game_with_records, state: :completed) }

      it 'is valid' do
        expect(game.valid?).to be true
      end
    end
  end

  describe '#game_records' do
    let(:game) { build(:game) }

    it 'has many' do
      game_record = build(:game_record)
      game.game_records << game_record
      expect(game.game_records).to eq [game_record]
    end
  end
end
