require 'rails_helper'

RSpec.describe 'player/update' do
  let!(:player) { Player.create(name: 'Karl') }

  before do
    visit players_path
    click_on(player.name.to_s)
    click_on('Edit Player')
  end

  context 'when clicking on the edit button' do
    it 'redirects to the edit player page' do
      expect(page).to have_current_path(edit_player_path(player))
    end
  end

  context 'when submitting the form' do
    context 'with a player name' do
      valid_new_player_name = 'Cassidy'

      before do
        find_field('Enter New Player Name').set(valid_new_player_name)
        click_button 'Update Player'
      end

      it 'redirects to the player page' do
        expect(page).to have_current_path(player_path(player))
      end

      it 'updates the player name' do
        visit player_path(player)
        expect(page).to have_content(valid_new_player_name)
      end

      it 'displays a success notice message' do
        visit player_path(player)
        expect(page).to have_content('Player successfully updated.')
      end
    end

    context 'without a player name' do
      before do
        find_field('Enter New Player Name').set('')
        click_button 'Update Player'
      end

      it 'stays on the form' do
        expect(page).to have_current_path(edit_player_path(player))
      end

      it 'displays an error message' do
        expect(page).to have_content('Please enter a valid name')
      end
    end
  end
end
