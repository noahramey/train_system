require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/train')
require('pg')

# DB = PG.connect({:dbname => "transit_system_test"})

get('/') do
  erb(:index)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end
