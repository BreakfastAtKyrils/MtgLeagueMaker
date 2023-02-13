RSpec.describe 'players/show' do
  let!(:jules) { create(:player, name: 'Jules', decks: [nissa]) }
  let(:nissa) { build(:deck, name: 'Nissa') }

  before do
    visit players_path
  end

  context 'when clicking on a player name' do
    before do
      click_on('Jules')
    end

    it 'navigates to the player path' do
      expect(page).to have_current_path(player_path(jules.id))
    end

    it 'renders a page with the player name' do
      expect(page).to have_content(jules.name)
    end

    it 'renders a page with the deck name' do
      expect(page).to have_content('Nissa')
    end
  end
end
