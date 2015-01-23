require 'httparty'
require 'nokogiri'


class HtmlQuery
  attr_reader :links, :url, :first_name, :last_name

  def initialize(scholar, full_page = nil)
    @scholar = scholar.split(" ")
    @first_name = @scholar[0]
    @last_name = @scholar[1]
    @raw_text = full_page
  end

  def url
    @url = "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}"
  end

  def raw_text
    @raw_text ||= HTTParty.get(@url).body
  end

  def page
    Nokogiri::HTML(raw_text)
  end

  def article_title_links
    page.css(".gs_rt a").to_a
  end


end
