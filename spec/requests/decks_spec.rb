require 'rails_helper'

RSpec.describe 'decks' do
  it_behaves_like 'a get request' do
    let(:record) { create(:deck, name: 'Ragavan') }
    let(:path) { "/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Ragavan') }
    end
  end

  it_behaves_like 'a post request' do
    let(:path) { '/decks.json' }
    let(:deck) { create(:deck) }
    let(:valid_request_params) do
      { deck: { name: 'Omnath', player_id: deck.player_id } }
    end
    let(:invalid_request_params) do
      { deck: { name: nil } }
    end
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Omnath') }
    end
  end

  it_behaves_like 'a delete request' do
    let(:record) { create(:deck, name: 'Tivit') }
    let(:path) { "/decks/#{record.id}.json" }
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Tivit') }
    end
  end

  it_behaves_like 'a put request' do
    let(:record) { create(:deck, name: 'Purphoros') }
    let(:player) { create(:player, name: 'Jules') }
    let(:path) { "/decks/#{record.id}.json" }
    let(:valid_request_params) do
      { deck: { name: 'Kiki-Jiki', player_id: player.id } }
    end
    let(:invalid_request_params) do
      { deck: { name: nil } }
    end
    let(:expected_json_attributes) do
      { deck: hash_including(name: 'Kiki-Jiki', player_id: player.id) }
    end
  end
end
