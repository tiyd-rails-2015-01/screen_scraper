##allows input of search term
require 'minitest/autorun'
require 'minitest/pride'
require 'httparty'
require 'nokogiri'
require './scholar_scraper'


require './article.rb'
require './format.rb'

class ScholarScraperTest < Minitest::Test

  def test_we_have_an_article_class
    assert Article
  end

  def test_we_have_a_format_class
    assert Format
  end

  def test_00_takes_one_parameter
    assert ScholarScraper.new("Test Author")
  end

  def test_pageContent
    scraper = ScholarScraper.new("Carlo Tomasi")
    assert scraper.pageContent != nil
  end

  def test_format_initializes
    assert format = Format.new
  end

  def test_article_initializes
    assert article = Article.new("Arbitrary", "1900","Arbitrary","Arbitrary")
  end


  # def test_citation_include_year
  #   scraper = ScholarScraper.new("Carlo Tomasi",Nokogiri::HTML(File.open("./carlo.html")))
  #   scraper.getPage
  #   scraper.getTitles
  #   scraper.getYears
  #   scraper.getAuthors
  #   scraper.getLocations
  #
  #   formatter = Format.new
  #   assert formatter.makeCitation( scraper.getArticles ).match(/[12]\d{3}/) != ""
  #
  # end


##nokogiri successfully gets some data

##an array of links is created

##an array of titles is created

##an array of authors is created

##an array of publication years is created -- NOTE: how is this being stored??
## => sanity check years: something starting with "19" or "20" might be a fair assumption??

##check that each output has a year

##check that each output has a title

##check that year and title belong to same entry

##print info for each entry with correct formatting <- break this down in greater detail
    ##author, "Title" in "Confrence Name", city, state, year, pages
end
