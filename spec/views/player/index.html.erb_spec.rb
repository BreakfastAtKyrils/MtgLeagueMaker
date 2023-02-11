require 'rails_helper'
require 'spec_helper'

RSpec.describe 'players/index' do
  before do
    karl = build(:player, name: 'Karl')
    jules = build(:player, name: 'Jules')

    assign(:players, [karl, jules])
  end

  context 'when creating 2 players' do
    it 'renders a list that includes both players names' do
      render

      expect(rendered).to include('Karl', 'Jules')
    end
  end
end
