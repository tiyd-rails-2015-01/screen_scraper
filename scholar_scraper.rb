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





# # Get the results page for Carlo Tomasi
# page = Nokogiri::HTML(HTTParty.get("http://scholar.google.com/scholar?q=carlo+tomasi&hl=en&as_sdt=0,34").body)
#
# # Get an array of links to titles
# article_title_links = page.css(".gs_rt a")
#
# # Pull out all the titles
# titles = article_title_links.map {|l| l.children[0].to_s}
#
# # Find all the publication years
# years = page.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)}
#
# # Write out all the publications in the form "2013 - Paper's Awesome Title"
# titles.each_with_index do |t, i|
#   puts "#{years[i]} - #{t}"
# end
