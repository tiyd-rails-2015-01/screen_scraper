require 'httparty'
require 'nokogiri'
require './article'

def get_user_input
  gets.chomp
end

class ScholarScraper
  attr_reader :author

  def initialize(author)
    @author= author.split(" ")
    @first_name=@author[0]
    @last_name=@author[1]
  end

  def url
    @url= "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}&hl=en&as_sdt=0,34"
  end

  def get_page
    @page = Nokogiri::HTML(HTTParty.get(url).body)
  end

  def title_links
    title_links = get_page.css(".gs_rt a")
  end

end




#
# # Pull out all the titles
# titles = article_title_links.map {|l| l.children[0].to_s}
#
# # Find all the publication years
# years = @page.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)}
#
# # Write out all the publications in the form "2013 - Paper's Awesome Title"
# titles.each_with_index do |t, i|
#   puts "#{years[i]} - #{t}"
# end
