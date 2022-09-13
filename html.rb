require 'open-uri'

class HTML
  attr_reader :value

  def initialize(url)
    @url = url
    @value = nil

    load_site
  end

  def load_site
    @value = URI.open(@url)
  end
end