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
  account = GithubAccount.new(params[:username])
  if account.valid?
    @favourite_language = account.favourite_language
    haml :favourite
  else
    @error = account.error
    haml :what_is_your_favourite
  end
end

get '/design' do
  haml :design
end
