require 'open-uri'

class HTML
  attr_reader :value

  def initialize(url, javascript)
    @url = url
    @javascript = javascript
    @value = nil

    load_site
  end

  def load_site
    @value = URI.open(@url)
  end
end