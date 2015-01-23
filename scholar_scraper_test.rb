require 'minitest/autorun'
require 'minitest/pride'
require './scholar_scraper.rb'
require './article.rb'

$mock_inputs = []
def get_user_input
  $mock_inputs.shift
end

class ScholarScraperTest < Minitest::Test
  def test_user_link
    author = ScholarScraper.new("Carlo Tomasi")
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
    author = ScholarScraper.new("Carlo Tomasi")
    #author.user_link.page_body.title_creation
    assert author.title_creation.include?("Good features to track")
  end

    #when I query for an author, it returns that author's titles in an array
end
