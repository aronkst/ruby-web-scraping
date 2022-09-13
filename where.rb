require 'nokogiri'

class Where
  attr_reader :values

  def initialize(find, html)
    @find = find
    @html = html

    @values = {}

    load_document
    where_values
  end

  private

  def load_document
    @document = Nokogiri::HTML(@html)
  end

  def where_values
    @find.keys.each do |key|
      if is_list?(key)
        @values[key] = find_list(key)
      else
        @values[key] = find_one(key)
      end
    end
  end

  def is_list?(key)
    !@find[key]["find"].nil?
  end

  def find_value(document, where, attr)
    if attr.nil?
      document.at(where).content
    else
      document.at(where).attr(attr)
    end
  rescue
    nil
  end

  def find_one(key)
    find_value(@document, @find[key]["where"], @find[key]["attr"])
  end

  def find_list(key)
    list_values = []

    @document.search(@find[key]["where"]).each do |document_child|
      list_values_child = {}

      @find[key]["find"].keys.each do |key_child|
        find_child = @find[key]["find"][key_child]
        list_values_child[key_child] = find_value(document_child, find_child["where"], find_child["attr"])
      end

      list_values.push(list_values_child)
    end

    list_values
  end
end