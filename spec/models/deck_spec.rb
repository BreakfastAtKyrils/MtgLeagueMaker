require 'rails_helper'

RSpec.describe Deck do
  describe '#name' do
    let(:player_id) { Player.find_by(name: 'Pavle').id }
    let(:deck) { described_class.find_by(player_id: player_id) }

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
