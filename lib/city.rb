require('pry')

class City
  attr_reader(:name, :id)
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities")
    cities = []
      returned_cities.each() do |city|
        name = city.fetch("name")
        id = city.fetch("id").to_i()
        cities.push(City.new({:id => id, :name => name }))
      end
      cities
    end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_city)
    self.name().==(another_city.name()).&(self.id().==(another_city.id()))
  end

  def self.find(id)
    # found_city = City.all().select{|city| city.id() == id }
    # return found_city
    found_city = nil
    City.all().each() do |city|
      if city.id() == id
        found_city = city
      end
    end
    found_city
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train_id}, #{self.id()});")
    end
  end

  def trains
     city_trains = []
     results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id()};")
     results.each() do |result|
       train_id = result.fetch("train_id").to_i()

       train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")

       name = train.first().fetch('name')
       id = train.first().fetch('id').to_i()
       departure_time = train.first().fetch('departure_time')
       departure_location = train.first().fetch('departure_location')
       arrival_time = train.first().fetch('arrival_time')
       arrival_location = train.first().fetch('arrival_location')

       city_trains.push(Train.new({:id => id, :name => name, :departure_time => departure_time, :departure_location=> departure_location, :arrival_time => arrival_time, :arrival_location=> arrival_location}))
     end
     city_trains
   end

  def delete
    DB.exec("DELETE FROM stops WHERE city_id = #{self.id()};")
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

end
