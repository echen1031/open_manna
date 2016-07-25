namespace :import_verses do
  task import: :environment do
    excel_file = 'db/open_manna_verses.xls'
    parsed_verses_excel_doc = Roo::Spreadsheet.open(excel_file, extension: :xls).parse
    parsed_verses_excel_doc.each_with_index do |row, i|
      next if i == 0
      Verse.create(reference: row[1])
      print "."
    end
  end

  task fill_verse_text: :environment do
    Verse.all.each do |v|
      verse_service = BibleVerseApiService.new(v.reference)
      verse_text = verse_service.retrieve_verse_text
      v.update_attributes(text: verse_text)
      print "."
    end
  end
end
