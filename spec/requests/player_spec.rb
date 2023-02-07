require 'rails_helper'

RSpec.describe Player do
  describe 'GET /index' do
    it 'returns http success' do
      get '/player/index'
      expect(response).to have_http_status(:success)
    end

    context 'when players exists' do
      it 'renders valid json' do
        jules = create(:player, name: 'Jules')
        pavle = create(:player, name: 'Pavle')

        get '/player/index'
        body = JSON.parse(response.body)
        expect(body['players']).to eq [{ 'name' => jules.name }, { 'name' => pavle.name }]
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/player/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/player/edit'
      expect(response).to have_http_status(:success)
    end
  end
end
