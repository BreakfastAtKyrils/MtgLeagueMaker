require 'rails_helper'

RSpec.describe 'deck/destroy' do
  let!(:player) { Player.create(name: 'Karl') }
  let!(:deck) { Deck.create(name: 'Llanowar Elf', player: player) }

  before do
    visit players_path
    click_on(player.name.to_s)
    click_on(deck.name.to_s)
    click_on('Delete Deck')
  end

  context 'when clicking on the destroy button' do
    it 'redirects to the player page' do
      expect(page).to have_current_path(player_path(player))
    end

    it 'removes the deck from the player decks' do
      expect(page).not_to have_content(deck.name)
    end
  end
end
