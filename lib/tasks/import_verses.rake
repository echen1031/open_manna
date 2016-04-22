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
end
