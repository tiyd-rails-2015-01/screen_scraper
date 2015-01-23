require 'minitest/autorun'
require 'minitest/pride'
require './scholar_scraper.rb'
require './article.rb'

class ScreenScraperTest < Minitest
  def test_user_link

    assert_equal "http://scholar.google.com/scholar?q=carlo+tomasi&hl=en&as_sdt=0,34", user_link
  end

  def assert_class_article_exists
    Article
  end
end
