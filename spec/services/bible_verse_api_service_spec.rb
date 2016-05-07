require 'rails_helper'

RSpec.describe BibleVerseApiService do
  describe 'Retrieving verse reference API' do
    before do
      response = "stubbed response"
      stub_request(:get, /api.lsm.org/).to_return(status: 200, body: response)
    end

    it 'it sends the verse text' do
      verse = create(:verse)
      verse_ref = verse.reference
      client = BibleVerseApiService.new(verse_ref)

      response = client.retrieve_verse_text

      expect(response).to eq response
    end
  end
end

