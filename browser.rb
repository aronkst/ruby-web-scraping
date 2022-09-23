require 'ferrum'

class Browser
  attr_reader :value

  def initialize(url)
    @url = url

    load_browser

    @browser.quit
  end

  def load_browser
    @browser = Ferrum::Browser.new(timeout: 20, browser_options: { 'no-sandbox': nil })
    @browser.go_to(@url)
    full_load
    @value = @browser.body
  rescue
    @value = nil
  end

  def full_load
    @browser.execute(full_load_script)
    full_load_wait
  end

  def full_load_script
    <<~TEXT
      function sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms))
      }
      async function fullLoad() {
        await sleep(3000)
        for (let i = 0; i < 20; i++) {
          window.scrollTo(0, Math.floor(document.body.scrollHeight / 20) * i + 1)
          await sleep(200)
        }
        let divShow = document.createElement("div")
        divShow.setAttribute("id", "full_load_crawler_promocao")
        divShow.appendChild(document.createTextNode("..."))
        document.body.appendChild(divShow)
      }
      fullLoad()
    TEXT
  end

  def full_load_wait
    timer = 0
    node = nil
    while node.nil? || timer <= 10
      node = @browser.at_css('#full_load_crawler_promocao')
      timer += 1
      sleep(1)
    end
  end
end