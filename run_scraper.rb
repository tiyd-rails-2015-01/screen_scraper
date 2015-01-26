require 'httparty'
require 'nokogiri'
require './scholar_scraper'
require 'pry'

scholar = ScholarScraper.new("John Smith")
puts scholar.bibliography
