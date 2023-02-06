require 'rails_helper'

RSpec.describe Deck do
  describe '#name' do
    context 'when absent' do
      let(:deck) { build(:deck, name: nil) }

      it 'is invalid' do
        expect(deck.valid?).to be false
      end

      it 'raises a database error' do
        expect { deck.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:deck) { build(:deck, name: 'Isamaru') }

      it 'is valid' do
        expect(deck.valid?).to be true
      end
    end
  end

  describe '#player' do
    context 'when absent' do
      let(:deck) { build(:deck, player: nil) }

      it 'is invalid' do
        expect(deck.valid?).to be false
      end

      it 'raises a database error' do
        expect { deck.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:deck) { build(:deck, player: player) }
      let(:player) { build(:player) }

      it 'is valid' do
        expect(deck.valid?).to be true
      end
    end
  end
end
