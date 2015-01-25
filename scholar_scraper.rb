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
    @authors = nil
    @locations = nil
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

  def getAuthors
    authors = []
    # @authors = @full_page.css(".gs_a a").map {|a| a.children[0..-1].to_s.gsub(/<\/?[^>]*>/,"") }
    lines = @full_page.css(".gs_a").map {|a| a.children[0..-1]}

    lines.each do |a|
      articles = a.to_s.gsub(/<(.*?)>/,"")
      n = articles.gsub(/(?=\s-).*/,"")
      # (?<=-\s).*
      authors << n.split(', ')
    end
    @authors = authors
  end


  def getLocations
    # # @locations = @full_page.css(".gs_a").map {|a| a.children[0..-1].to_s.gsub(/<\/?[^>]*>/,"")}
    # @locations = @full_page.css(".gs_a").map {|a| a.children[0..-1].to_s.split(/<\/?[^>]*>|[,-]/)}
    #
    # #cleanup
    # @locations.each do |loc|
    #
    #   loc.each do |chunk|
    #     chunk.delete!("…")
    #     chunk.strip!
    #   end
    #
    #   loc.delete("")
    #   loc.delete(" ")
    #   loc.delete("  ")
    #   loc.delete("…")
    # end


    locations = []
    lines = @full_page.css(".gs_a").map {|a| a.children[0..-1]}

    lines.each do |a|
      articles = a.to_s.gsub(/<(.*?)>/,"")
      # n = articles.gsub(/.*(?<=\s-\s)/,"")
      n = articles.gsub(/(?<=\s-\s).*/,"")
      articles.slice!(n)

      n = articles.gsub(/(?=\s-).*/,"")
      n.slice!("  …")
      n.slice!(" …")

      # (?<=-\s).*
      # locations << n.split(', ')
      locations << n
    end
    @locations = locations
  end

  def getArticles
    arrayOfArticles = []
    @titles.each_with_index do |title, index|
      arrayOfArticles << Article.new(title, @years[index], @authors[index], @locations[index])
    end

    return arrayOfArticles
  end

  def showArticles
    bunchOfArticles = getArticles
    moreAuthors = false

    bunchOfArticles.each do |article|
      string = ""
      article.author.each do |a|
        if a == "…"
          moreAuthors = true
        else
          string << "#{a}, "
        end
      end

      if moreAuthors
        string << "et al., "
      end

      # puts "#{string}\"#{article.title},\" in <name of conf>, #{article.year}"

      citation = "#{string}\"#{article.title},\" "
      if article.location.match(/\A[12]\d{3}/) == nil
        citation << "in "
      end

      puts "#{citation}#{article.location}"

      # puts "#{string}\"#{article.title},\" in #{article.location}"
      # puts "#{article.location}"
      puts ""
    end

    # J. K. Author, “Title of paper,” in Unabbreviated Name of Conf., City of Conf.,
    # Abbrev. State (if given), year, pp.
    # xxx-xxx.
  end
end

scraper = ScholarScraper.new("Carlo Tomasi",Nokogiri::HTML(File.open("./carlo.html")))
scraper.getPage
scraper.getTitles
scraper.getYears
scraper.getAuthors
scraper.getLocations
scraper.showArticles
