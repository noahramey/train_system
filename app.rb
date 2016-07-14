require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/train')
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname => "transit_system"})

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
  @cities = City.all()
  erb(:train)
end

get("/trains/:id/edit") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_edit)
end

patch("/trains/:id") do
  @cities = City.all()
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  if params.fetch('line') == ""
    line = @train.line()
  else
    line = params.fetch('line').to_i()
  end
  if params.fetch('seats') == ""
    seats = @train.seats()
  else
    seats = params.fetch('seats').to_i()
  end
  city_ids = params.fetch("city_ids", [])
  @train.update({line: line, seats: seats, city_ids: city_ids})
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
  @trains = Train.all()
  erb(:city)
end

get("/cities/:id/edit") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_edit)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  if params.fetch("name") == ""
    name = @city.name()
  else
    name = params.fetch("name")
  end
  if params.fetch("state") == ""
    state = @city.state()
  else
    state = params.fetch("state")
  end
  train_ids = params.fetch("train_ids", [])
  @city.update({name: name, state: state, train_ids: train_ids})
  @trains = Train.all()
  erb(:city)
end

delete("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @cities = City.all()
  erb(:cities)
end
