require 'rails_helper'

RSpec.describe BibleVerseApiService do
  describe 'Retrieving verse reference API' do
    before do
      response = "{\n\"verses\": [\n\t{\"ref\": \"John 1:1\", \"text\": \"In the beginning was the Word, and the Word was with God, and the Word was God.\"}\n\t]}"

      stub_request(:get, /api.lsm.org/).to_return(status: 200, body: response)
    end

    it 'it sends the verse text' do
      verse = create(:verse)
      verse_ref = verse.reference
      client = BibleVerseApiService.new(verse_ref)

      verse = client.retrieve_verse_text

      expect(verse).to eq verse
    end
  end
end

