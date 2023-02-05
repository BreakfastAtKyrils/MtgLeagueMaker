require 'rails_helper'

RSpec.describe Game do
  describe '#played_at' do
    let(:game) { described_class.first }

    it 'is required by the model' do
      subject.played_at = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.played_at = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end
  end
end
