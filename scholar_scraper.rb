#### Requirements
#
#* The program must take a researcher's name from the user.  You decide how this should be done.  Is it a command line argument?  Is it a prompt?
#* The program must use HTTParty (or a similar gem) to connect to Google Scholar.
#* The program must use Nokogiri (or a similar gem) to traverse the HTML document's components.
#* At least three classes should be defined in your code.
#* The results of a search should be encapsulated in a single object (this object may, of course, wrap other objects as instance variables).
#
### Normal Mode
#
#The steps of the project will look something like this:
#
#* Fork this repository and clone it to your local machine.
#* Run the code.  You'll have to do something with gems and bundler before it will work.
#* Interpret what you think the code is trying to do.  It's not doing it correctly, but it does have a clear intent.
#  * Write tests to capture this intent.
#  * Modify the code to make the tests pass.
#  * Refactor the code to have an object-oriented structure.  Ensure that the tests still pass along the way (otherwise, it wouldn't be refactoring).
#  * Once your refactor is complete, begin writing code test-first.  Write a test to capture one of the new requirements below, make sure the test fails, then write code to make the test pass.  Refactor as needed.
#
#    In the simplest case, your program should:
#
#      * Take a researcher's name from the user
#      * Output a bibliography (via `puts` or similar) of the first 10 results in IEEE citation format (the format typically used in Computer Science).
#
#      Note that this citation format has MANY subrequirements, so test them one at a time.
#
#      The link to the IEEE citation formats is given below.  Consider the results to all be "Conference Technical Articles."

require 'httparty'
require 'nokogiri'
require './article.rb'
require 'pry'


class ScholarScraper
  def initialize(author, full_page=nil)
    @author = author.split
    @first_name=@author[0]
    @last_name=@author[1]
    @full_page = full_page
    @articles = []
  end


  def user_link
    "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}&hl=en&as_sdt=0,34"
  end

  def page_body
    Nokogiri::HTML(page_content)
  end

  def title_creation
    article_title_links = page_body.css(".gs_ri").css(".gs_rt a")
    titles = article_title_links.map {|l| l.children[0].to_s}
    return titles
  end

  #title is "gs_rt"
  #
  #all the names "gs_a" inside <a href>
  #
  #years"gs_a" after <a href>
  #
  #location "gs_r" "gs_ri" "gs_a" after <a href> after years

  def grab_articles
    title = []
    name = []
    year = []
    location = []
    articles = page_body.css(".gs_r").css(".gs_ri")
    articles.each do |article|
      title << article.css(".gs_rt a").children[0].to_s #.map {|l| l.children[0].to_s}
      name << article.css(".gs_a a").children[0].to_s #unless name.match(/([A-Z])[\s-]/)
      #if name == name.match(/([A-Z])[\s-]/)
      #  name << (page_body.css(".gs_a a").children[0]).to_s =+ (page_body.css(".gs_a a").css("b").children[0])
      #end
      year <<  article.css(".gs_a").to_s.match(/[12]\d{3}/)
      temp_location = article.css(".gs_a").children.last.to_s.match(/[\s-][A-Z](...)*[\s][\s]/).to_s#.names[0]
      location << temp_location ? temp_location :""      #/[\s-][A-Z](...)*[\s][\s]/)  #{}/[\s-][\s]*[A-Z][a-z]+[^,]/)
    end
    binding.pry
  end


  def years
    years = page_body.css(".gs_a").map {|y| y.to_s.match(/[12]\d{3}/)}
    return years
  end

  def other_authors
    author = page_body.css(".gs_ri").css(".gs_a").map {|l| l.children[0].to_s.match(/([A-Z]*)[\s-]([A-Z][a-z]*)/)}
    #binding.pry
    return author
  end



  def list
    title_creation.each_with_index do |t, i|
      puts "#{years[i]} - #{t}"
      @articles << Article.new(years[i],t)
    end
    #binding.pry
  end

  def page_content
    @full_page ||= HTTParty.get(user_link).body
  end



end

#puts"What is their first name"
#user_input1 = gets.chomp
#puts"What is their last name"
#user_input2 = gets.chomp

#get user input as string, splt at " "
