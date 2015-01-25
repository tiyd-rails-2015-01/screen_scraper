require './scholar_scraper.rb'

puts "gimme a name"
name = gets.chomp
scraper = ScholarScraper.new(name)

articles = scraper.create_articles

articles.each do |article|
  puts article.bibliography
end
