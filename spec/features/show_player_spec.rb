require 'rails_helper'

RSpec.describe 'players/show' do
  let!(:jules) { create(:player, name: 'Jules', decks: [nissa, omnath]) }
  let(:nissa) { build(:deck, name: 'Nissa') }
  let(:omnath) { build(:deck, name: 'Omnath') }

  before do
    visit players_path
  end

  context 'when clicking on a player name' do
    before do
      click_on 'Jules'
    end

    it 'navigates to the player path' do
      expect(page).to have_current_path(player_path(jules))
    end

    it 'renders a page with the player name' do
      expect(page).to have_content('Jules')
    end

    it 'renders a page with the deck names' do
      aggregate_failures do
        %w[Nissa Omnath].each do |deck_name|
          expect(page).to have_content(deck_name)
        end
      end
    end
  end
end
