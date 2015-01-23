require './scholar_scraper.rb'
require './article.rb'

class Article
  attr_accessor :year, :title
  def initialize(year, title)
    @year = year
    @title = title
  end


end
