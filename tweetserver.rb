require 'sinatra'
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ARGV[2]
  config.consumer_secret     = ARGV[3]
  config.access_token        = ARGV[4]
  config.access_token_secret = ARGV[5]
end

use Rack::Auth::Basic, 'Auth Required' do |username, password|
  username == ARGV[0] and password == ARGV[1]
end

configure do
  set :server, 'webrick'
end

get '/:text' do
  client.update(params[:text])
end
