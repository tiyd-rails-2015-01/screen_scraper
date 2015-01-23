require 'httparty'
require 'nokogiri'
require 'pry'

# require './page.rb'
require './article.rb'
require './format.rb'


####
# class ScholarScraper
# => searchingForAuthor
# => searchingForLastName
# => searchingForFirstName
# => articles
# initialize( searchingForAuthor, rawPageInfo )
# pageContent
# getPage

class ScholarScraper

  def initialize(author, full_page = nil)
    @author
    # @searchingForFirstName = author[0]
    # @searchingForLastName = author[1]
    @articles=[]
    @url = "http://scholar.google.com/scholar?q=#{@author}&hl=en&as_sdt=0,34"
    @full_page = full_page
    @titles = nil
    @years = nil
  end

  def pageContent
    return HTTParty.get(@url).body
  end


  def getPage
    return @full_page ||= Nokogiri::HTML(pageContent)
  end


  def getTitles
    article_title_links = @full_page.css(".gs_ri").css(".gs_rt a")
    @titles = article_title_links.map {|l| l.children[0].to_s}
  end


  def getYears
    @years = @full_page.css(".gs_a").map {|y| y.to_s.match(/[12]\d{3}/)}#<-looking for a string of 4 digits
  end


  def getArticles
    arrayOfArticles = []
    @titles.each_with_index do |title, index|
      arrayOfArticles << Article.new(title, @years[index],nil,nil)
    end

    return arrayOfArticles
  end

  def showArticles
    bunchOfArticles = getArticles

    bunchOfArticles.each do |article|
      puts "#{article.year} - #{article.title}"
    end
  end
end

scraper = ScholarScraper.new("Carlo Tomasi",Nokogiri::HTML(File.open("./carlo.html")))
scraper.getPage
scraper.getTitles
scraper.getYears
scraper.showArticles
