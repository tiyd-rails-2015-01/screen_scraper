require 'httparty'
require 'nokogiri'


class HtmlQuery
  attr_reader :links, :url, :first_name, :last_name

  def initialize(scholar, full_page = nil)
    @scholar = scholar.split(" ")
    @first_name = @scholar[0].downcase
    @last_name = @scholar[1].downcase
    @raw_text = full_page
    @url = self.url
  end

  def url
    "https://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}"
  end

  def raw_text
    @raw_text #||= HTTParty.get(@url).body
  end

  def page
    Nokogiri::HTML(raw_text)
  end

  def article_title_links(page)
    page.css(".gs_rt a")
  end

  def titles(title_links)
    title_links.map {|l| l.children[0].to_s}
  end

  def years(year_links)
    year_links.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)}
  end

  def results(titles)
    titles.each_with_index do |t, i|
      puts "#{years[i]} - #{t}"
    end
  end

end
