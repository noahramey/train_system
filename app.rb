require('sinatra')
require('sinatra/reloader')
also_reload("lib/**/*.rb")
require('./lib/train')
require('pg')

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
  erb(:train_edit_success)
end
