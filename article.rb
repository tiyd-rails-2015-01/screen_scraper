#require './scholar_scraper.rb'


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
