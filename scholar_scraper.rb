require 'httparty'
require 'nokogiri'
require './article.rb'
require 'pry'


class ScholarScraper
  def initialize(author, full_page=nil)
    @author = author.split
    @first_name=@author[0]
    @last_name=@author[1]
    @full_page = full_page
    @articles = []
  end

  def user_link
    "http://scholar.google.com/scholar?q=#{@first_name}+#{@last_name}&hl=en&as_sdt=0,34"
  end

  def page_body
    Nokogiri::HTML(page_content)
  end

  def create_articles
    articles = page_body.css(".gs_r").css(".gs_ri")
    articles.each do |article|
      title = article.css(".gs_rt a").children[0].to_s
      name = String.new
      article.css(".gs_a a").children.each_with_index do |item, index|
        name += ", " unless index == 0
        name += item.to_s.gsub("<b>", "").gsub("</b>", "")
      end
      year =  article.css(".gs_a").to_s.match(/[12]\d{3}/)
      temp_conf_name = article.css(".gs_a").children.last.to_s.match(/[\s-][A-Z](...)*[\s][\s]/).to_s
      conf_name = temp_conf_name ? temp_conf_name :""
      @articles << Article.new(name.gsub(" , " , " "), title, year, conf_name)
    end
    return @articles
    binding.pry
  end

  def page_content
    @full_page ||= HTTParty.get(user_link).body
  end
end
