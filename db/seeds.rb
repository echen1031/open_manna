unless Rails.env.production?
  Dir[File.dirname(__FILE__) + '/seed/*.rb'].each {|file| require file }
else
  puts "No seeding to production."
end
