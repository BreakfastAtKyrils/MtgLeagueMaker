require 'rails_helper'

RSpec.shared_examples 'an object with a delete endpoint' do |path, model, key, json|
  describe '#delete' do
    context 'when given a valid resource id' do
      before do
        delete "#{path}#{resource[:id]}.json"
      end

      it 'returns the correct http response' do
        expect(response).to have_http_status :ok
      end

      it 'deletes the resource from the database' do
        expect { model.find(resource[:id]) }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'returns the object as json' do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[key]).to include(json)
      end
    end

    context 'when given an invalid resource id' do
      before do
        invalid_id = 'invalid_id'
        delete "#{path}#{invalid_id}.json"
      end

      it 'returns the correct http response' do
        expect(response).to have_http_status :not_found
      end

      it 'returns a json error message' do
        expect(response.body).to eq 'Record not found'
      end
    end
  end
end
