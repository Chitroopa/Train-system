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

get('/train/new') do
  erb(:train_form)
end

get('/train') do
  erb(:trains)
end

post('/trains') do
  erb(:trains)
end
