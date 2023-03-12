require 'rails_helper'
require './spec/support/rspec_helpers'

RSpec.describe 'games/create' do
  6.times do |index|
    unique_id = index + 1
    player_name = "player#{unique_id}"
    deck_name = "deck#{unique_id}"
    let!(player_name.to_sym) { create(:player, id: unique_id, name: player_name) }
    let!(deck_name.to_sym) { create(:deck, id: unique_id, name: deck_name, player_id: unique_id) }
  end

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
      date = Date.current

      before do
        click_on 'Create a New Game'
        fill_in 'game_played_at', with: date
        select_option('#game_state', 'completed')

        6.times do |index|
          unique_id = index + 1
          player_name = "player#{unique_id}"
          deck_name = "deck#{unique_id}"
          result = 'draw'
          select_option("#game_game_records_attributes_#{index}_player_id", player_name)
          select_option("#game_game_records_attributes_#{index}_deck_id", deck_name)
          select_option("#game_game_records_attributes_#{index}_result", result)
        end

        click_button 'Create Game'
      end

      it 'redirects to the list of games' do
        expect(page).to have_current_path(games_path)
      end

      it 'displays a success notice message' do
        visit games_path
        expect(page).to have_content('New game successfully added to the database.')
      end

      it 'displays the game in the list of games' do
        visit games_path
        expect(page).to have_content(Date.current.strftime('%d %B, %Y'))
      end
    end

    context 'without a date' do
      date = nil

      before do
        click_on 'Create a New Game'
        fill_in 'game_played_at', with: date
        select_option('#game_state', 'pending')

        6.times do |index|
          unique_id = index + 1
          player_name = "player#{unique_id}"
          deck_name = "deck#{unique_id}"
          result = 'draw'
          select_option("#game_game_records_attributes_#{index}_player_id", player_name)
          select_option("#game_game_records_attributes_#{index}_deck_id", deck_name)
          select_option("#game_game_records_attributes_#{index}_result", result)
        end

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Must enter a valid date')
      end
    end

    context 'with no wins or draws for a completed game' do
      date = Date.current

      before do
        click_on 'Create a New Game'
        fill_in 'game_played_at', with: date
        select_option('#game_state', 'completed')

        6.times do |index|
          unique_id = index + 1
          player_name = "player#{unique_id}"
          deck_name = "deck#{unique_id}"
          result = 'loss'
          select_option("#game_game_records_attributes_#{index}_player_id", player_name)
          select_option("#game_game_records_attributes_#{index}_deck_id", deck_name)
          select_option("#game_game_records_attributes_#{index}_result", result)
        end

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        expect(page).to have_content('Must have 1 winner or at least 2 draws')
      end
    end
  end
end
