require('rspec')
require('train')
require('pg')
require('city')

DB = PG.connect({:dbname=>'train_system_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
  end
end
