require 'nokogiri'

class Find
  attr_reader :values

  def initialize(find, html)
    @find = find
    @html = html
    @values = {}

    load_site
    find_values
  end

  private

  def load_site
    @document = Nokogiri::HTML(@html)
  end

  def find_values
    @find.keys.each do |key|
      value = @find[key]
      if value["attr"].nil?
        content = @document.at(value["find"]).content
      else
        content = @document.at(value["find"]).attr(value["attr"])
      end

      @values[key] = content
    end
  end
end