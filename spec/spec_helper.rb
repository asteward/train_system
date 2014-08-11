require 'rspec'
require 'lines'
require 'stations'
require 'pg'

DB = PG.connect({:dbname => 'trains_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM station *;")
    DB.exec("DELETE FROM line *;")
  end
end
