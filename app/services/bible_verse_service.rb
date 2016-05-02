class BibleVerseService
  def initialize(verse_string)
    @verse = verse_string
  end

  def retrieve_text
    url = "https://api.lsm.org/recver.php?String=#{@verse}&Out=json"
    begin
      @response = RestClient.get url
      return JSON.parse(@response)["verses"][0]["text"]
    rescue => e
      e.response
    end
  end
end
