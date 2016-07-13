require('rspec')
require('pg')
require('train')

DB = PG.connect({dbname: "transit_system_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
  end
end
