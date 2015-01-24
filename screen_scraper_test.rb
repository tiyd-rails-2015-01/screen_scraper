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

  def test_02_name_converts_to_url
    html_query = HtmlQuery.new("Carlo Tomasi")
    assert_equal html_query.url, "https://scholar.google.com/scholar?q=carlo+tomasi"
    html_query2 = HtmlQuery.new("Albert Einstein")
    assert_equal html_query2.url, "https://scholar.google.com/scholar?q=albert+einstein"
  end

  def test_03_article_title_links_scrapes_article_links
    carlo = HtmlQuery.new("Carlo Tomasi")
    # carlo2 = HtmlQuery.new("Carlo Tomasi")
    url = carlo.url
    p url
    raw_text = carlo.raw_text(url)
    # p raw_text
    page = carlo.page(raw_text)
    # p page
    title_links = carlo.article_title_links(page)
    # p title_links
    titles = carlo.titles(title_links)
    # p titles
    raw_text2 = carlo.raw_text(url)
    years = carlo.page(raw_text2)
    p carlo.years(years)
    # assert (carlo.titles).include? "Good features to track"
  end


end
# def test_01_html_query_returns_proper_url
#   input = HtmlQuery.new("albert einstein")
#   assert_equal input,
# # end
