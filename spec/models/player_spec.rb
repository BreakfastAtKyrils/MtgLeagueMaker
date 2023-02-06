require 'rails_helper'

RSpec.describe Player do
  describe '#name' do
    context 'when absent' do
      let(:player) { build(:player, name: nil) }

      it 'is invalid' do
        expect(player.valid?).to be false
      end

      it 'raises a database error' do
        expect { player.save(validate: false) }
          .to raise_error ActiveRecord::NotNullViolation
      end
    end

    context 'when present' do
      let(:player) { build(:player, name: 'Jules') }

      it 'is valid' do
        expect(player.valid?).to be true
      end
    end
  end
end
