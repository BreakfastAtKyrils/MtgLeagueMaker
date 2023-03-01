require 'rails_helper'

RSpec.describe 'deck/update' do
  let!(:player) { Player.create(name: 'Karl') }
  let!(:deck) { Deck.create(name: 'Llanowar Elf', player: player) }

  before do
    visit players_path
    click_on(player.name.to_s)
    click_on(deck.name.to_s)
    click_on('Edit Deck')
  end

  context 'when clicking on the edit deck button' do
    it 'redirects to the edit deck page' do
      expect(page).to have_current_path("/players/#{player.id}/decks/#{deck.id}/edit")
    end
  end

  context 'when submitting the form' do
    context 'with a deck name' do
      deck_name = 'Muxus'

      before do
        find_field('Enter New Deck Name').set(deck_name)
        click_button 'Update Deck'
      end

      it 'redirects to the player decks page' do
        expect(page).to have_current_path(player_decks_path(player))
      end

      it 'updates the deck name' do
        expect(page).to have_content(deck_name)
      end

      it 'displays a success notice message' do
        expect(page).to have_content('Deck successfully updated')
      end
    end

    context 'without a deck name' do
      deck_name = nil

      before do
        find_field('Enter New Deck Name').set(deck_name)
        click_button 'Update Deck'
      end

      it 'redirects to the player decks page' do
        expect(page).to have_current_path(player_decks_path(player))
      end

      it 'displays an error notice message' do
        expect(page).to have_content('Please enter a valid name')
      end
    end
  end
end
