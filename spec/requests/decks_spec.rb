require 'rails_helper'

RSpec.describe 'decks' do
  it_behaves_like 'a get request' do
    let(:record) { create(:deck) }
    let(:path) { "/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Isamaru') }
    end
  end
end
