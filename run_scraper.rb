require 'httparty'
require 'nokogiri'
require './scholar_scraper'
require './article'
require 'pry'

scholar = ScholarScraper.new("John Smith")
scholar.bibliography
