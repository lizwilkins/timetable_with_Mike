require 'pg'
require 'rspec'
require 'line'
require 'station'
require 'stop'

DB = PG.connect({:dbname => 'timetable_test', :host => 'localhost'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
  end
end