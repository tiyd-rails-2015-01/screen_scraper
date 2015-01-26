require 'httparty'
require 'nokogiri'
require './html_query'


puts "Name a scholar whose work you are interested in, such as Albert Einstein."

scholar = gets.chomp

new_query = HtmlQuery.new(scholar)
page = new_query.page
title_links = new_query.article_title_links(page)
titles = new_query.titles(title_links)
years = new_query.years(page)
results = new_query.results(titles)
