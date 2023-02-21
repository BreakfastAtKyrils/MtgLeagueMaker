require 'rails_helper'
require_relative '/Users/kyril-remillard/boyos_ladder/spec/support/shared_examples/delete_endpoint'

RSpec.describe 'DELETE /players.json' do
  let(:player) { Player.create(name: 'Karl') }

  player_json = {
    name: 'Karl'
  }

  it_behaves_like 'an object with a delete endpoint', '/players/', Player, :player, player_json do
    let(:resource) { player }
  end
end
