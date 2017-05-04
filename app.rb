require('pry')
require('launchy')
require('sinatra')
require('sinatra/reloader')
require('./lib/city')
require('./lib/train')
require('pg')
also_reload('./**/*.rb')

DB = PG.connect({:dbname=>'train_system_test'})

get('/') do
  erb(:index)
end

get('/system_operator') do
  @trains = Train.all()
  @cities = City.all()
  erb(:train_system)
end

get('/rider') do
  @cities = City.all()
  erb(:rider)
end

post('/rider/trains') do
  city_id = params.fetch('city_id').to_i()
  @city = City.find(city_id)
  erb(:rider_train)
end

get('/rider/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:rider_train_info)
end
get('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end

patch('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train_info)
end

delete('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:train_system)
end

get('/cities/:id') do
  @city = City.find(params.fetch('id').to_i())
  @trains = Train.all()
  erb(:city_info)
end

patch('/cities/:id') do
  @city = City.find(params.fetch("id").to_i())
  train_ids = params.fetch('train_ids')
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city_info)
end

delete('/cities/:id') do
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:train_system)
end

get('/city/new') do
  erb(:city_form)
end

post('/city/new') do
  name = params.fetch("name")
  new_city = City.new({:name => name, :id => nil})
  new_city.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:train_system)
end

get('/train/new') do
  erb(:train_form)
end

post('/train/new') do
  name = params.fetch("name")
  departure_time = params.fetch("departure_time")
  departure_location = params.fetch("departure_location")
  arrival_time = params.fetch("arrival_time")
  arrival_location = params.fetch("arrival_location")
  new_train = Train.new({:name => name, :departure_time => departure_time, :departure_location => departure_location, :arrival_time => arrival_time, :arrival_location => arrival_location, :id => nil})
  new_train.save()
  @trains = Train.all()
  @cities = City.all()
  erb(:train_system)
end

get('/train') do
  erb(:trains)
end

post('/trains') do
  erb(:trains)
end
