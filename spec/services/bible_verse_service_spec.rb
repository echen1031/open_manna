require 'rails_helper'

RSpec.describe BibleVerseService do
  describe '#retrieve_text' do
    it 'calls the lsm recovery version api' do
      @verse = 'John 1:1'
      url = "https://api.lsm.org/recver.php?String=#{@verse}&Out=json"

      response = RestClient.get url

      binding.pry
      expect(response).to be_an_instance_of(String)
    end
  end
end

