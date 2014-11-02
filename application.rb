$LOAD_PATH << './lib'

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'haml'
require 'github_account'

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

error do
  e = request.env['sinatra.error']
  Kernel.puts e.backtrace.join("\n")
  'Application error'
end

helpers do
  # add your helpers here
end

# root page
get '/' do
  haml :root
end


get '/favourite' do
  haml :what_is_your_favourite
end

post '/favourite' do
  @favourite_language = GithubAccount.new(params[:username]).favourite_language
  puts @favourite_language
  haml :favourite
end
