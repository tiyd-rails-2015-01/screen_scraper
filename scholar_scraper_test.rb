require 'minitest/autorun'
require 'minitest/pride'
require './scholar_scraper.rb'
require './article.rb'

class ScholarScraperTest < Minitest::Test
  def raw_html
    File.open("carlo.html").read
  end

  def test_user_link
    author = ScholarScraper.new("Carlo Tomasi", raw_html)
    assert_equal "http://scholar.google.com/scholar?q=carlo+tomasi&hl=en&as_sdt=0,34", author.user_link.downcase
  end

  def test_assert_article_class_exists
    Article
  end

  #def test_return_nokagiri_parsed_page
  #  author = ScholarScraper.new("Carlo Tomasi")
  #  page = author.user_link.downcase
  #  assert_equal Nokogiri::HTML(HTTParty.get(page).body), author.page_body
  #end

  def test_return_article_titles
    author = ScholarScraper.new("Carlo Tomasi",raw_html)
    #author.user_link.page_body.title_creation
    assert author.title_creation.include?("Good features to track")
  end

  def test_return_years
    author = ScholarScraper.new("Carlo Tomasi",raw_html)
    assert_match (/1992/), author.years.to_s
  end

  def test_list_pub_titles
    author = ScholarScraper.new("Carlo Tomasi",raw_html)
    author.list.include?("1994 - Good features to track")
  end
end
