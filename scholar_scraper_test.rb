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
    author_url = ScholarScraper.new("Carlo Tomasi")
    assert_equal "http://scholar.google.com/scholar?q=carlo+tomasi&hl=en&as_sdt=0,34", author_url.user_link.downcase
  end

  def test_assert_class_article_exists
    Article
  end
end
