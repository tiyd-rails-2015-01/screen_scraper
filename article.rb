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

    citation << "#{@author}, \"#{@title},\" "
    if @conf_name != nil
      citation << "in #{@conf_name}, "
    end

    return citation
  end

end


tomasi = Article.new("C Tomasi", "Good features to track", "1994", nil)
puts tomasi.bibliography


# J. K. Author, “Title of paper,” in Unabbreviated Name of Conf., City of Conf.,
# Abbrev. State (if given), year, pp.xxx-xxx.

# article_title_links = page_body.css(".gs_ri").css(".gs_rt a")
# titles = article_title_links.map {|l| l.children[0].to_s}
# return titles
