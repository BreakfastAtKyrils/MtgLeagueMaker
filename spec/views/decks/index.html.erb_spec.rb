require 'rails_helper'

RSpec.describe 'decks/index', type: :system do
  describe 'deck index page' do
    context 'when no decks in the database' do
      it 'shows the right content' do
        visit decks_path
        expect(page).to have_content('Listing Decks')
      end
    end

    context 'when there are decks in the database' do
      it 'shows the right content' do
        karl = create(:player, name: 'Karl')
        krark = create(:deck, name: 'Krark', player: karl)

        visit decks_path
        expect(page).to have_content(krark.name)
      end
    end
  end
end
