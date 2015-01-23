require 'httparty'
require 'nokogiri'


class HtmlQuery
  attr_reader :links, :url, :first_name, :last_name

  def initialize(scholar, full_page = nil)
    @scholar = scholar.split(" ")
    @first_name = @scholar[0]
    @last_name = @scholar[1]
    @full_page = full_page
  end

  def url
    @url = "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}"
  end

  def page_text
    @page_text = @full_page ||= HTTParty.get(@url).body
  end

  def get_page
    Nokogiri::HTML(@page_text)
  end

  def article_title_links
    get_page.css(".gs_rt a").to_a
  end


end
