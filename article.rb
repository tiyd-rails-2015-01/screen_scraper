######
# class Article
# => @title
# => @year
# => @author
# => @location
# initialize( title, year, author, location)
###########

class Article
  attr_reader :title, :year, :author, :location

  def initialize(title, year,author,location)
    @title = title
    @year = year
    @author = author
    @location = location
  end
end
