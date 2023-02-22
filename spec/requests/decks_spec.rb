require 'rails_helper'

RSpec.describe 'decks' do
  # it_behaves_like 'a delete request' do
  #   let(:player) { Player.create(name: 'Karl') }
  #   let(:record) { Deck.create(name: 'Krark', player: player) }
  #   let(:path) { "/players/#{record.id}.json" }
  #   let(:expected_json_attributes) do
  #     { player: hash_including(name: 'Karl') }
  #   end
  # end

  it_behaves_like 'a get request' do
    let(:player) { Player.create(name: 'Jules') }
    let(:record) { Deck.create(name: 'Nissa', player: player) }
    let(:path) { "/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Nissa') }
    end
  end

  # it_behaves_like 'a post request' do
  #   let(:path) { '/players.json' }
  #   let(:valid_request_params) do
  #     { player: { name: 'Pavle' } }
  #   end
  #   let(:invalid_request_params) do
  #     { player: { name: nil } }
  #   end
  #   let(:expected_json_attributes) do
  #     { player: hash_including(name: 'Pavle') }
  #   end
  # end

  # it_behaves_like 'a put request' do
  #   let(:record) { create(:player, name: 'Karl') }
  #   let(:path) { "/players/#{record.id}.json" }
  #   let(:valid_request_params) do
  #     { player: { name: 'Pavle' } }
  #   end
  #   let(:invalid_request_params) do
  #     { player: { name: nil } }
  #   end
  #   let(:expected_json_attributes) do
  #     { player: hash_including(name: 'Pavle') }
  #   end
  # end
end
