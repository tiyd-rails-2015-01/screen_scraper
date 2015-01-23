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
    html_query = HtmlQuery.new("Carlo Tomasi")
    html_query.article_title_links

    assert html_query.article_title_links.is_a?(Array)
  end


end
# def test_01_html_query_returns_proper_url
#   input = HtmlQuery.new("albert einstein")
#   assert_equal input,
# # end
