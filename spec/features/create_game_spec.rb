require 'rails_helper'

RSpec.describe 'games/create' do
  before do
    visit games_path
  end

  context 'when clicking the create game button' do
    before do
      click_on 'Create a New Game'
    end

    it 'navitages to the new game form' do
      expect(page).to have_current_path(new_game_path)
    end
  end

  context 'when submitting the form' do
    context 'with a date' do
      before do
        click_on 'Create a New Game'
        select('13', from: 'game_played_at_3i')
        select('March', from: 'game_played_at_2i')
        select('2023', from: 'game_played_at_1i')
        click_button 'Create Game'
      end

      it 'redirects to the list of game' do
        expect(page).to have_current_path(games_path)
      end

      it 'displays a success notice message' do
        visit games_path
        expect(page).to have_content('New game successfully added to the database.')
      end
    end

    context 'without a date' do
      before do
        click_on 'Create a New Game'
        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Please enter a valid date')
      end
    end
  end
end
