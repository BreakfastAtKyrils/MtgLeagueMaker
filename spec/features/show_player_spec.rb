require 'rails_helper'
require 'spec_helper'

RSpec.describe 'players/show' do
  context 'when clicking on a player name' do
    # I tried a before/do bloc to dry this up. But I couldn't get the jules variable to be accessible in the it blocs
    it 'the current path is the player path' do
      jules = Player.create(name: 'Jules')
      Deck.create(name: 'Nissa', player: jules)

      visit players_path
      click_on('Jules')
      expect(page).to have_current_path(player_path(jules.id))
    end

    it 'renders a page with the player name' do
      jules = Player.create(name: 'Jules')
      Deck.create(name: 'Nissa', player: jules)

      visit players_path
      click_on('Jules')
      expect(page).to have_content(jules.name)
    end

    it 'renders a page with the deck name' do
      jules = Player.create(name: 'Jules')
      Deck.create(name: 'Nissa', player: jules)

      visit players_path
      click_on('Jules')
      expect(page).to have_content('Nissa')
    end
  end
end
