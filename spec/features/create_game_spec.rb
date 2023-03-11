require 'rails_helper'
require './spec/support/rspec_helpers'

RSpec.describe 'games/create' do
  let!(:player) { Player.create(name: 'Karl') }

  let!(:deck) { create(:deck) }

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
      date = '2023/01/01'

      before do
        click_on 'Create a New Game'
        fill_in 'game_played_at', with: date
        select_option('#game_state', 'pending')

        6.times do |index|
          select_option("#game_game_records_attributes_#{index}_player_id", player.name)
          select_option("#game_game_records_attributes_#{index}_deck_id", deck.name)
          select_option("#game_game_records_attributes_#{index}_result", 'loss')
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
    end

    context 'without a date' do
      date = nil

      before do
        click_on 'Create a New Game'
        fill_in 'game_played_at', with: date
        select_option('#game_state', 'pending')

        6.times do |index|
          select_option("#game_game_records_attributes_#{index}_player_id", player.name)
          select_option("#game_game_records_attributes_#{index}_deck_id", deck.name)
          select_option("#game_game_records_attributes_#{index}_result", 'loss')
        end

        click_button 'Create Game'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(new_game_path)
      end

      it 'displays an error message' do
        # will change this message once I refactor the error message function in applicationHelper
        expect(page).to have_content('Please enter a valid name')
      end
    end
  end
end
