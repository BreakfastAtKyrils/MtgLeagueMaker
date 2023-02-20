require 'rails_helper'

RSpec.describe 'player/update' do
  let!(:player) { Player.create(name: 'Karl') }

  before do
    visit players_path
    click_on(player.name.to_s)
    click_on('Delete Player')
  end

  context 'when clicking on the destroy button' do
    it 'redirects to the players page' do
      expect(page).to have_current_path(players_path)
    end

    it 'removes the player from players page' do
      expect(page).not_to have_content(player.name)
    end
  end
end
