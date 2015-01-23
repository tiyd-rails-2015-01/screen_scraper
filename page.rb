#####
# class Page
# => @everything
# => @titles
# => @years
# => @authors
# => @locations
# getTitles
# getAuthors
# getYears
# getLocations
# getArticles
#########

class Page

  def initialize( everything )
    @everything = everything
    @titles = nil
    @years = nil
    @authors = nil
    @locations = nil
  end

  def getTitles
    article_title_links = @everything.css(".gs_rt a")
    @titles = article_title_links.map {|l| l.children[0].to_s}
  end

  def getYears
    @years = @everything.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)} #<-looking for a string of 4 digits
  end

  def getArticles
    ###return array of Articles
    @titles.each_with_index do |t, i|
      puts "#{@years[i]} - #{t}"
    end
  end
end
