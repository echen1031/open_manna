class BibleVerseApiService
  def initialize(verse_string)
    @verse = verse_string
  end

  def retrieve_verse_text
    url = "https://api.lsm.org/recver.php?String=#{@verse}&Out=json"
    @response = RestClient.get url
    JSON.parse(@response)["verses"][0]["text"]
  end
end
