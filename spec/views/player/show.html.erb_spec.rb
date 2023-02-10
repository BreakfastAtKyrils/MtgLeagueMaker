require 'rails_helper'

RSpec.describe 'player/show' do
  context 'when creating a player with 1 deck' do
    before do
      omnath = create(:deck, name: 'Omnath')
      pavle = create(:player, name: 'Pavle', decks: [omnath])

      assign(:player, pavle)
      url = "http://localhost:3000/players/#{pavle.id}"
      visit(url)
    end

    it 'renders a page with the player name' do
      expect(page).to have_content('Pavle')
    end

    it 'renders a page with their deck name' do
      expect(page).to have_content('Omnath')
    end
  end
end
