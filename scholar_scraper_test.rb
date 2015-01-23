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
    $mock_inputs.clear
    $mock_inputs << "Carlo Tomasi"
    assert_equal "http://scholar.google.com/scholar?q=carlo+tomasi&hl=en&as_sdt=0,34", user_link
  end

  def test_assert_class_article_exists
    Article
  end
end
