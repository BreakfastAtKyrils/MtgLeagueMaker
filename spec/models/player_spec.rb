require 'rails_helper'

RSpec.describe Player do
  describe '#name' do
    it 'is required by the model' do
      subject.name = nil
      expect(subject.valid?).to be false
    end

    it 'is required at the database level' do
      subject.name = nil

      expect { subject.save(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end
  end
end
