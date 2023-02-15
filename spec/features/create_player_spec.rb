require 'rails_helper'

RSpec.describe 'players/create' do
  player_name = 'Max'

  before do
    visit players_path
  end

  context 'when clicking on "Create New Player"' do
    before do
      click_on('Create a New Player')
    end

    it 'navigates to the player/new path' do
      expect(page).to have_current_path(new_player_path)
    end
  end

  context 'when submitting the form with player_name = Max' do
    before do
      click_on('Create a New Player')
      find_field('Enter Player Name').set(player_name)
      click_button 'Create Player'
    end

    it 'redirects to the players/index' do
      expect(page).to have_current_path(players_path)
    end

    it 'displays a success notice message' do
      visit players_path
      expect(page).to have_content("New player successfully added to the database: #{player_name}")
    end

    it 'adds the player name to the players/index page' do
      visit players_path
      expect(page).to have_content(player_name)
    end
  end

  context 'when submitting the form with no player name' do
    before do
      visit new_player_path
      find_field('Enter Player Name').set('')
      click_button 'Create Player'
    end

    it 're-renders the players/new page' do
      expect(page).to have_current_path(new_player_path)
    end

    it 'displays an error message' do
      expect(page).to have_content('Please enter a valid name')
    end
  end
end
