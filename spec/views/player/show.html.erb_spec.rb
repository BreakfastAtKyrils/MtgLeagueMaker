require 'rails_helper'

RSpec.describe 'player/show', driver: :rack_test do
  context 'when creating a player with 1 deck' do
    before do
      pavle = create(:player, name: 'Pavle')
      omnath = create(:deck, name: 'Omnath', player: pavle)

      assign(:player, pavle)
      assign(:decks, omnath)

      visit("http://localhost:3000/players/#{pavle.id}")
    end

    it 'renders a page with the player name' do
      expect(page).to have_content('Pavle')
    end

    it 'renders a page with their deck name' do
      expect(page).to have_content('Omnath')
    end
  end
end
