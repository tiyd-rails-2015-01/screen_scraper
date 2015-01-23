require './scholar_scraper.rb'

puts "gimme a name"
name = gets.chomp
scraper = ScholarScraper.new(name)

puts scraper.bibliography
