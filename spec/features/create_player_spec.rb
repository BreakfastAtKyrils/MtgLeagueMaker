require 'rails_helper'

RSpec.describe 'players/create' do
  before do
    visit players_path
  end

  context 'when clicking the create player button' do
    before do
      click_on 'Create a New Player'
    end

    it 'navitages to the new player form' do
      expect(page).to have_current_path(new_player_path)
    end
  end

  context 'when submitting the form' do
    context 'with a player name' do
      player_name = 'Max'

      before do
        click_on 'Create a New Player'
        find_field('Enter Player Name').set(player_name)
        click_button 'Create Player'
      end

      it 'redirects to the list of players' do
        expect(page).to have_current_path(players_path)
      end

      it 'displays a success notice message' do
        visit players_path
        expect(page).to have_content("New player successfully added to the database: #{player_name}")
      end

      it 'displays the player in the list of players' do
        visit players_path
        expect(page).to have_content(player_name)
      end
    end

    context 'without a player name' do
      before do
        visit new_player_path
        find_field('Enter Player Name').set('')
        click_button 'Create Player'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_player_path)
      end

      it 'displays an error message' do
        expect(page).to have_content("can't be blank")
      end
    end
  end
end
