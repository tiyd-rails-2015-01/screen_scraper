require 'httparty'
require 'nokogiri'


class HtmlQuery

  def initialize(scholar, full_page=nil)
    @scholar = scholar.split(" ")
    @first_name = @scholar[0]
    @last_name = @scholar[1]
    @full_page = full_page

  end

  def url
    "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}"
  end

  def page_text
    @full_page ||= HTTParty.get(url).body
  end

  def get_page
    Nokogiri::HTML(page_text)
  end



end
