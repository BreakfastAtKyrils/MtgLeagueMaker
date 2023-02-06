require 'rails_helper'
require 'time'

RSpec.describe Game do
  describe '#played_at' do
    context 'when absent' do
      let(:game) { build(:game, played_at: nil) }

      it 'is invalid' do
        expect(game.valid?).to be false
      end

      it 'raises a database error' do
        expect { game.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:game) { build(:game, played_at: Time.zone.now) }

      it 'is valid' do
        expect(game.valid?).to be true
      end
    end
  end
end
