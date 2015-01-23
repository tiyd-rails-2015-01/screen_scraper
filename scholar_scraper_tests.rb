# In the simplest case, your program should:
#
# Take a researcher's name from the user
# Output a bibliography (via puts or similar) of the first 10 results in IEEE citation format (the format typically used in Computer Science).
# Note that this citation format has MANY subrequirements, so test them one at a time.
#
# The link to the IEEE citation formats is given below. Consider the results to all be "Conference Technical Articles."


require 'minitest/autorun'
require 'minitest/pride'
require './scholar_scraper'
require './article'

class ScholarScraperTests <Minitest::Test
  def test_article_class_exists
    assert Article
  end

  def raw_html
    File.open("carlo.html").read
  end

  def test_can_make_url
    test_author=ScholarScraper.new("Carlo Tomasi")
    assert_equal "http://scholar.google.com/scholar?q=Carlo+Tomasi&hl=en&as_sdt=0,34", test_author.url
  end

  def test_array_of_article_title_links
    test_author=ScholarScraper.new("Carlo Tomasi", raw_html)
    assert_match (/ieeexplore/), test_author.title_links.to_s
  end

  def test_pull_out_titles
    test_author=ScholarScraper.new("Carlo Tomasi", raw_html)
    assert_match (/Good features to track/), test_author.titles.to_s
  end

  def test_publication_years
    test_author=ScholarScraper.new("Carlo Tomasi", raw_html)
    assert_match (/1994/), test_author.years.to_s
  end

  def test_write_out_publications
    test_author=ScholarScraper.new("Carlo Tomasi", raw_html)
    assert_equal "1994 - Good features to track", test_author.bibliography[0]
  end
end
