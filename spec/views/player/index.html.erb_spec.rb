require 'rails_helper'
require 'spec_helper'

RSpec.describe 'players/index' do
  before do
    karl = create(:player, name: 'Karl')
    jules = create(:player, name: 'Jules')

    assign(:players, [karl, jules])
  end

  context 'when creating 2 players' do
    it 'renders a list with a count of 2' do
      render

      tds = css_select('tr>td')
      expect(tds.count).to eq 2
    end

    it 'renders a list that includes both players names' do
      render

      expect(rendered).to include('Karl', 'Jules')
    end
  end
end