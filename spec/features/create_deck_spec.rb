require 'rails_helper'

RSpec.describe 'decks/create' do
  let(:player) { create(:player) }

  before do
    visit player_path(player)
    click_on 'Add Deck'
  end

  context 'when clicking the add deck button' do
    it 'navitages to the new deck form' do
      expect(page).to have_current_path("/players/#{player.id}/decks/new")
    end
  end

  context 'when submitting the form' do
    context 'with a deck name' do
      deck_name = 'Tibalt'

      before do
        find_field('Enter Deck Name').set(deck_name)
        click_button 'Create Deck'
      end

      it 'redirects to the list of decks' do
        expect(page).to have_current_path(player_decks_path(player.id))
      end

      it 'displays a success notice message' do
        visit player_decks_path(player.id)
        expect(page).to have_content("New deck successfully added to the database: #{deck_name}")
      end

      it 'displays the deck in the list of decks' do
        visit player_decks_path(player.id)
        expect(page).to have_content(deck_name)
      end
    end

    context 'without a deck name' do
      before do
        find_field('Enter Deck Name').set(nil)
        click_button 'Create Deck'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(player_decks_path(player.id))
      end

      it 'displays an error message' do
        expect(page).to have_content('Please enter a valid name')
      end
    end
  end
end
