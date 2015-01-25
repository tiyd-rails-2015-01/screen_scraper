########
# class Format
# =>
# makeCitation( author, title, publication, conferenceAddress, year, pagenumbers)
#########

class Format
  def makeCitation( arrayOfArticles )
    bunchOfArticles = arrayOfArticles
    moreAuthors = false

    bunchOfArticles.each do |article|
      string = ""
      article.author.each do |a|
        if a == "…"
          moreAuthors = true
        elsif !a.empty?
          string << "#{a}, "
        end
      end

      if moreAuthors
        string << "et al., "
      end

      citation = "#{string}\"#{article.title},\" "
      if article.location.match(/\A[12]\d{3}/) == nil
        citation << "in "
      end

      puts "#{citation}#{article.location}\n\n"
    end

  end
end
