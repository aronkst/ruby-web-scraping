require 'sinatra'
require_relative 'html'
require_relative 'find'

set :port, 3000

post '/html' do
  payload = get_payload
  html = HTML.new(payload["url"])

  content_type :text
  html.value
end

post '/find' do
  payload = get_payload
  html = HTML.new(payload["url"])
  find = Find.new(payload["find"], html.value)

  content_type :json
  find.values.to_json
end

private

def get_payload
  request.body.rewind
  JSON.parse request.body.read
end