require 'httparty'
require 'nokogiri'
require './article'
require 'pry'

class ScholarScraper
  attr_accessor :author

  def initialize(author, full_page=nil)
    @author= author.split(" ")
    @first_name=@author[0]
    @last_name=@author[1]
    @articles=[]
    @titles= []
    @full_page=full_page
  end

  def url
    "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}&hl=en&as_sdt=0,34"
  end

  def page_text
    @full_page ||= HTTParty.get(url).body
  end

  def get_page
    @page = Nokogiri::HTML(page_text)
  end

  def title_links
    title_links = get_page.css(".gs_ri").css(".gs_rt a")
  end

  def titles
    @titles= title_links.map {|l| l.children[0].to_s}
     return @titles
  end

  def years
    years= []
    years = get_page.css(".gs_a").map {|y| y.to_s.match(/[12]\d{3}/)}
    return years
  end

  def bibliography
    publishers=[]
    formated_publishers= []
    formatted_titles = []
    bibliography = []
    split_bibliography= []
    articles= []
    authors= []
    final_bibliography= []
    titles.each_with_index do |t, i|
      formatted_titles << "#{years[i]} - #{t}"
    end
    get_page.css(".gs_a").each do |bib|
      bibliography << bib
    end
    bibliography.each { |element|
      split_bibliography << element.text }
    formatted_titles

    split_bibliography.each do |x|
      authors << x.split("-")[0]
      publishers << x.split("-")[1]
    end

    count=0
    while count<10
      final_bibliography << "#{authors[count]}, #{titles[count]}, #{publishers[count]}"
      count +=1
    end
    final_bibliography.to_s

  end


end
<<<<<<< HEAD






#
#
# # Write out all the publications in the form "2013 - Paper's Awesome Title"
# titles.each_with_index do |t, i|
#   puts "#{years[i]} - #{t}"
# end
=======
>>>>>>> e2bae14e5d37359024dbc09c9c3645add1ebb4f6
