require 'open-uri'
require_relative 'browser'

class HTML
  attr_reader :value

  def initialize(url, javascript)
    @url = url
    @javascript = javascript

    load_site
  end

  def load_site
    if @javascript
      @value = Browser.new(@url).value
    else
      @value = URI.open(@url)
    end
  rescue
    @value = nil
  end
end