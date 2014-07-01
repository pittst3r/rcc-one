require 'factory_girl'
require 'capybara/poltergeist'

World(FactoryGirl::Syntax::Methods)

Capybara.javascript_driver = :poltergeist
