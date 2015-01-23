require 'minitest/autorun'
require 'minitest/pride'
require 'httparty'
require 'nokogiri'
require './html_query'

class ScreenScraperTest < Minitest::Test

  def carlo
    File.open("carlo.html").read
  end

  def test_00_html_query_class_exists
    assert HtmlQuery
  end

  def test_01_html_query_has_arguments
    assert HtmlQuery.new("Carlo Tomasi")
  end

  def test_02_article_titles_in_array
    assert article_title_links.is_a?
  end


end
# def test_01_html_query_returns_proper_url
#   input = HtmlQuery.new("albert einstein")
#   assert_equal input,
# # end
