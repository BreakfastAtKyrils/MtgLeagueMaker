require 'rails_helper'

RSpec.shared_examples 'a delete request' do
  context 'when given a valid resource id' do
    before do
      delete valid_path
    end

    it 'returns the correct http response' do
      expect(response).to have_http_status :ok
    end

    it 'deletes the record from the database' do
      expect { record.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns the object as json' do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to include(expected_json_attributes)
    end
  end

  context 'when given an invalid resource id' do
    before do
      delete invalid_path
    end

    it 'returns the correct http response' do
      expect(response).to have_http_status :not_found
    end

    it 'returns a json error message' do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body).to include({ errors: ['Record not found'] })
    end
  end
end
