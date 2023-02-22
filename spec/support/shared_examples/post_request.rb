require 'rails_helper'

RSpec.shared_examples 'a post request' do
  context 'when given valid object attributes' do
    before do
      post path, params: valid_request_params
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :created
    end

    it 'returns the object as json' do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to include(expected_json_attributes)
    end
  end

  context 'when given invalid object attributes' do
    before do
      post path, params: invalid_request_params
    end

    it 'returns the correct status code' do
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'returns a json object with an errors key' do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to include(:errors)
    end
  end
end
