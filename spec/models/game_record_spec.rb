require 'rails_helper'

RSpec.describe GameRecord do
  let(:player) { build(:player) }
  let(:deck) { build(:deck) }
  let(:game) { build(:game) }

  describe '#record_type' do
    context 'when absent' do
      let(:game_record) { build(:game_record, record_type: nil) }

      it 'is invalid' do
        expect(game_record.valid?).to be false
      end

      it 'raises a database error' do
        expect { game_record.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game_record) { build(:game_record) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end
  end

  describe '#player' do
    context 'when absent' do
      let(:game_record) { build(:game_record, player: nil) }

      it 'is invalid' do
        expect(game_record.valid?).to be false
      end

      it 'raises a database error' do
        expect { game_record.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game_record) { build(:game_record) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end
  end

  describe '#deck' do
    context 'when absent' do
      let(:game_record) { build(:game_record, deck: nil) }

      it 'is invalid' do
        expect(game_record.valid?).to be false
      end

      it 'raises a database error' do
        expect { game_record.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game_record) { build(:game_record) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end
  end

  describe '#game' do
    context 'when absent' do
      let(:game_record) { build(:game_record, game: nil) }

      it 'is invalid' do
        expect(game_record.valid?).to be false
      end

      it 'raises a database error' do
        expect { game_record.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game_record) { build(:game_record) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end
  end
end
