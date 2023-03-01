require 'rails_helper'

RSpec.describe 'deck/destroy' do
  let!(:player) { create(:player, name: 'Karl') }
  let!(:deck) { create(:deck, name: 'Llanowar Elf', player: player) }

  before do
    visit players_path
    click_on player.name
    click_on deck.name
    click_on 'Delete'
  end

  context 'when clicking on the destroy button' do
    it 'redirects to the player page' do
      expect(page).to have_current_path(player_decks_path(player))
    end

    it 'removes the deck from the player decks' do
      expect(page).not_to have_content(deck.name)
    end
  end
end
