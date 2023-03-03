require 'rails_helper'

RSpec.describe 'game/destroy' do
  let!(:game) { create(:game) }

  before do
    visit games_path
    click_on "Game ID: #{game.id}"
    click_on 'Delete'
  end

  context 'when clicking on the destroy button' do
    it 'redirects to the games page' do
      expect(page).to have_current_path(games_path)
    end

    it 'removes the game from games page' do
      expect(page).not_to have_content(game.id)
    end
    
    it 'displays a success notice message' do
      expect(page).to have_content('Game successfully deleted.')
    end
  end
end
