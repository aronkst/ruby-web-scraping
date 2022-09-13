require 'sinatra'
require_relative 'html'
require_relative 'where'
require_relative 'transform'

set :port, 3000

post '/html' do
  payload = get_payload
  html = HTML.new(payload["url"], payload["javascript"])

  content_type :text
  html.value
end

post '/find' do
  payload = get_payload
  html = HTML.new(payload["url"], payload["javascript"])
  find = Where.new(payload["find"], html.value)
  transform = Transform.new(payload["find"], find.values)

  content_type :json
  transform.values.to_json
end

private

def get_payload
  request.body.rewind
  JSON.parse request.body.read
end