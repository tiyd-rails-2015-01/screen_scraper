require 'httparty'
require 'nokogiri'


class HtmlQuery
  attr_reader :links, :url, :first_name, :last_name

  def initialize(scholar, full_page = nil)
    @scholar = scholar.split(" ")
    @first_name = @scholar[0].downcase
    @second_name = @scholar[1]
    @third_name = @scholar[2]
    @last_name = @scholar[-1].downcase
    @raw_text = full_page
    @url = self.url
    @first_initial = @first_name[0].upcase
    @second_initial = @second_name[0].upcase
    @third_initial = @third_name[0].upcase
  end

  def url
    "https://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}"
  end

  def raw_text
    @raw_text ||= HTTParty.get(@url).body
  end

  def page
    Nokogiri::HTML(raw_text)
  end

  def article_title_links(page)
    page.css(".gs_rt a")[1..10]
  end

  def titles(title_links)
    title_links.map {|l| l.children[0].to_s}
  end

  def years(year_links)
    @years = year_links.css(".gs_a").map {|y| y.to_s.match(/\d{4}/)}
  end

  def results(titles)
    titles.each_with_index do |t, i|
      if @scholar.length == 3
        puts "#{@first_initial}. #{@second_initial}. #{@last_name.capitalize}, \"#{t},\" #{@years[i]}."
      elsif @scholar.length == 4
        puts "#{@first_initial}. #{@second_initial}. #{@third_initial} #{@last_name.capitalize}, \"#{t},\" #{@years[i]}."
      else
        puts "#{@first_initial}. #{@last_name.capitalize}, \"#{t},\" #{@years[i]}."
      end
    end
  end
end
