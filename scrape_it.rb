require 'httparty'
require 'nokogiri'
require 'pry'
require './scholar_scraper.rb'

require './article.rb'
require './format.rb'


puts "Enter an author:"
author = gets.chomp

# uncomment this to access locally stored search results test file
# scraper = ScholarScraper.new("Carlo Tomasi",Nokogiri::HTML(File.open("./carlo.html")))
scraper = ScholarScraper.new(author)


scraper.getPage
scraper.getTitles
scraper.getYears
scraper.getAuthors
scraper.getLocations

formatter = Format.new
formatter.makeCitation( scraper.getArticles )
