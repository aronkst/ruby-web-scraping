require 'open-uri'
require_relative 'browser'

class HTML
  attr_reader :value

  def initialize(html)
    if html.is_a?(String)
      @value = html
    else
      @url = html["url"]
      @javascript = html["javascript"]
      
      load_site
    end
  end

  def load_site
    if @javascript
      @value = Browser.new(@url).value
    else
      @value = URI.parse(@url).open
    end
  rescue
    @value = nil
  end
end