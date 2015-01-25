require './scholar_scraper.rb'
require './article.rb'

class Article
  attr_accessor :author, :title, :year, :conf_name

  def initialize(author, title, year, conf_name)
    @author = author
    @title = title
    @year = year
    @conf_name = conf_name
  end

  def bibliography
    citation = ""
    if conf_name != ""
      citation << "#{@author}, \"#{@title}\", #{@conf_name}, #{@year} "
    else
      citation << "#{@author}, \"#{@title}\", #{@year} "
    end
    return citation
  end

end


#tomasi = Article.new("C Tomasi", "Good features to track", nil, "1994")
#puts tomasi.bibliography
