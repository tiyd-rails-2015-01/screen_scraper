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
# showArticles
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
    arrayOfArticles = []
    @titles.each_with_index do |title, index|
      arrayOfArticles << Article.new(title, @years[index],nil,nil)
      # puts "#{@years[index]} - #{title}"
    end

    return arrayOfArticles
  end

  def showArticles
    bunchOfArticles = getArticles

    bunchOfArticles.each do |article|
      puts "#{article.year} - #{article.title}"
    end
  end
end
