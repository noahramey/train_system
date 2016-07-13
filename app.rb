require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/train')
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname => "transit_system_test"})

get('/') do
  erb(:index)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end

get('/trains/new') do
  erb(:train_form)
end

post('/trains') do
  line = params.fetch('line').to_i()
  seats = params.fetch('seats').to_i()
  train = Train.new({line: line, seats: seats})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

get('/trains/:id') do
  @train = Train.find(params.fetch('id').to_i())
  erb(:train)
end

get("/trains/:id/edit") do
  @train = Train.find(params.fetch("id").to_i())
  erb(:train_edit)
end

patch("/trains/:id") do
  line = params.fetch('line').to_i
  seats = params.fetch('seats').to_i
  @train = Train.find(params.fetch("id").to_i())
  @train.update({line: line, seats: seats})
  erb(:train)
end

delete("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:trains)
end

######################################
get('/cities') do
  @cities = City.all()
  erb(:cities)
end

get('/cities/new') do
  erb(:city_form)
end

post('/cities') do
  name = params.fetch("name")
  state = params.fetch("state")
  city = City.new({name: name, state: state})
  city.save()
  @cities = City.all()
  erb(:cities)
end

get('/cities/:id') do
  @city = City.find(params.fetch('id').to_i())
  erb(:city)
end

get("/cities/:id/edit") do
  @city = City.find(params.fetch("id").to_i())
  erb(:city_edit)
end

patch("/cities/:id") do
  name = params.fetch("name")
  state = params.fetch("state")
  @city = City.find(params.fetch("id").to_i())
  @city.update({name: name, state: state})
  erb(:city)
end

delete("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @cities = City.all()
  erb(:cities)
end
