require 'minitest/autorun'
require 'minitest/pride'
require 'httparty'
require 'nokogiri'
require './scholar_scraper'
require './html_query'

class ScreenScraperTest < Minitest::Test

  def carlo
    File.open("carlo.html").read
  end

  def test_00_html_query_class_exists
    assert HtmlQuery
  end



end
# def test_01_html_query_returns_proper_url
#   input = HtmlQuery.new("albert einstein")
#   assert_equal input,
# # end
