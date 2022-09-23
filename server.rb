require 'sinatra'
require_relative 'html'
require_relative 'where'
require_relative 'transform'
require_relative 'convert'
require_relative 'exclude'

set :port, 3000

post '/html' do
  payload = body_json
  html = HTML.new(payload['html'])

  content_type :text
  html.value
end

post '/find' do
  payload = body_json
  html = HTML.new(payload['html'])
  find = Where.new(payload['find'], html.value)
  transform = Transform.new(payload['find'], find.values)
  convert = Convert.new(payload['find'], transform.values)
  exclude = Exclude.new(payload['find'], convert.values)

  content_type :json
  exclude.values.to_json
end

private

def body_json
  request.body.rewind
  JSON.parse request.body.read
end
