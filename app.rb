# coding: utf-8
require 'json'

# @@data = []
# @@count = 0
@@data = [{:id => 1, :text => 'aaaa'}]
@@count = 1

configure :development do
  config = YAML::load_file('config.yml')
end

configure :production do
  SOME_VALUE = ENV['SOME_VAUE']
end

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

get '/styles.css' do
  scss :styles
end

get '/script.js' do
  coffee :script
end

get '/' do
  haml :index
end

get '/messages' do
  content_type :json
  @@data.to_json
end

post '/messages' do
  request.body.rewind
  data = JSON.parse request.body.read
  content_type :json
  message = data.merge(:id => @@count += 1)
  @@data << message
  message.to_json
end
