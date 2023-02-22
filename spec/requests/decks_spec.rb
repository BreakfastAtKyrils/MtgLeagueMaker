require 'rails_helper'

RSpec.describe 'decks' do
  it_behaves_like 'a get request' do
    let(:player) { Player.create(name: 'Jules') }
    let(:record) { Deck.create(name: 'Nissa', player: player) }
    let(:path) { "/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Nissa') }
    end
  end
end
