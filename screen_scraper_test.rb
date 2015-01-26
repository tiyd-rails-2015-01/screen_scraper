require 'minitest/autorun'
require 'minitest/pride'
require 'httparty'
require 'nokogiri'
require './html_query'

class ScreenScraperTest < Minitest::Test

    RAW_TEXT = File.open("carlo.html").read

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
    carlo = HtmlQuery.new("Carlo Tomasi", RAW_TEXT)
    albert = HtmlQuery.new("Albert Einstein")
    page = carlo.page
    page2 = albert.page
    title_links = carlo.article_title_links(page)
    title_links2 = albert.article_title_links(page2)
    assert carlo.titles(title_links).include? "Good features to track"
    assert albert.titles(title_links2).include? "Can quantum-mechanical description of physical reality be considered complete?"
  end

  def test_04_years_returned_from_query
    carlo = HtmlQuery.new("Carlo Tomasi", RAW_TEXT)
    page = carlo.page
    years = carlo.years(page)
    assert years.to_s.include? "1998"
  end

  def test_05_prints_results
    carlo = HtmlQuery.new("Carlo Tomasi", RAW_TEXT)
    page = carlo.page
    title_links = carlo.article_title_links(page)
    titles = carlo.titles(title_links)
    years = carlo.years(page)
    results = carlo.results(titles)
    assert results.include? "Detection and tracking of point features"
  end

  def test_06_test_user_input_converts_to_url
    puts "Please enter the name of a scholar"
    @scholar = "Carlo Tomasi"
    carlo = HtmlQuery.new(@scholar)
    assert_equal true, carlo.url == "https://scholar.google.com/scholar?q=carlo+tomasi"
  end

  def test_07_user_input_returns_results
    @scholar = "Carlo Tomasi"
    carlo = HtmlQuery.new(@scholar, RAW_TEXT)
    page = carlo.page
    title_links = carlo.article_title_links(page)
    titles = carlo.titles(title_links)
    years = carlo.years(page)
    results = carlo.results(titles)
    assert results.include? "Detection and tracking of point features"
  end

  def test_08_results_work_with_multiple_names
    agnes = HtmlQuery.new("Agnes Smith Lewis")
    page = agnes.page
    title_links = agnes.article_title_links(page)
    titles = agnes.titles(title_links)
    years = agnes.years(page)
    results = agnes.results(titles)
    assert results.include? "Apocrypha syriaca"

  end
end
