require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL, type: :controller

  config.before type: :controller do
    Capybara.app = Sinatra::Application
    Sinatra::Application.set :environment, :test
  end
end
