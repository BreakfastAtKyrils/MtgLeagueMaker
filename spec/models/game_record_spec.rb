require 'rails_helper'

RSpec.describe GameRecord do
  describe '#result' do
    context 'when absent' do
      let(:game_record) { build(:game_record, result: nil) }

      it 'is invalid' do
        expect(game_record.valid?).to be false
      end

      it 'raises a database error' do
        expect { game_record.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present and in enum range' do
      let(:game_record) { build(:game_record, result: 0) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end

    context 'when negative' do
      it 'raises an argument error' do
        expect { build(:game_record, result: -1) }
          .to raise_error(ArgumentError)
          .with_message(/is not a valid result/)
      end
    end

    context 'when above enum range' do
      it 'raises an argument error' do
        expect { build(:game_record, result: 3) }
          .to raise_error(ArgumentError)
          .with_message(/is not a valid result/)
      end
    end

    context 'when 0' do
      let(:game_record) { build(:game_record, result: 0) }

      it 'is recorded as a loss' do
        expect(game_record.result).to eq 'loss'
      end
    end

    context 'when 1' do
      let(:game_record) { build(:game_record, result: 1) }

      it 'is recorded as a win' do
        expect(game_record.result).to eq 'win'
      end
    end

    context 'when 2' do
      let(:game_record) { build(:game_record, result: 2) }

      it 'is recorded as a draw' do
        expect(game_record.result).to eq 'draw'
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
      let(:player) { build(:player) }
      let(:game_record) { build(:game_record, player: player) }

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
      let(:deck) { build(:deck) }
      let(:game_record) { build(:game_record, deck: deck) }

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
      let(:game) { build(game: game) }
      let(:game_record) { build(:game_record) }

      it 'is valid' do
        expect(game_record.valid?).to be true
      end
    end
  end
end
