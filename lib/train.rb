class Train
  attr_reader(:name, :id, :departure_time, :departure_location, :arrival_time, :arrival_location)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @departure_time = attributes.fetch(:departure_time)
    @departure_location = attributes.fetch(:departure_location)
    @arrival_time = attributes.fetch(:arrival_time)
    @arrival_location = attributes.fetch(:arrival_location)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains")
    trains = []
      returned_trains.each() do |train|
        name = train.fetch("name")
        id = train.fetch("id").to_i()
        departure_time = train.fetch('departure_time')
        departure_location = train.fetch('departure_location')
        arrival_time = train.fetch('arrival_time')
        arrival_location = train.fetch('arrival_location')
        trains.push(Train.new({:id => id, :name => name, :departure_time => departure_time, :departure_location=> departure_location, :arrival_time => arrival_time, :arrival_location=> arrival_location}))
      end
      trains
    end

    def save
      result = DB.exec("INSERT INTO trains (name, departure_time, departure_location, arrival_time, arrival_location) VALUES ('#{@name}', '#{@departure_time}','#{@departure_location}','#{@arrival_time}','#{@arrival_location}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    def ==(another_train)
      (self.name() == another_train.name()) && (self.id() == another_train.id())  && (self.departure_time() == another_train.departure_time()) && (self.departure_location() == another_train.departure_location()) && (self.arrival_time() == another_train.arrival_time()) && (self.arrival_location() == another_train.arrival_location())
    end

    def self.find(id)
      # found_train = Train.all().select{|train| train.id() == id }
      # return found_train
      found_train = nil
      Train.all().each() do |train|
        if train.id() == id
          found_train = train
        end
      end
      found_train
    end

    def update(attributes)
      @name = attributes.fetch(:name, @name)
      @departure_time = attributes.fetch(:departure_time ,@departure_time)
      @departure_location = attributes.fetch(:departure_location, @departure_location)
      @arrival_time = attributes.fetch(:arrival_time, @arrival_time)
      @arrival_location = attributes.fetch(:arrival_location, @arrival_location)
      @id = self.id()
      DB.exec("UPDATE trains SET name = '#{@name}', departure_time = '#{@departure_time}', departure_location = '#{@departure_location}', arrival_time = '#{@arrival_time}', arrival_location = '#{@arrival_location}'  WHERE id = #{@id};")

      attributes.fetch(:city_ids, []).each() do |city_id|
        DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city_id}, #{self.id()});")
      end
    end

    def cities
      train_stops = []
      results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id()};")
      results.each() do |result|
        city_id = result.fetch("city_id").to_i()

        city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")

        name = city.first().fetch('name')
        id = city.first().fetch('id').to_i()

        train_stops.push(City.new({:id => id, :name => name}))
      end
      train_stops
    end

    def delete
      DB.exec("DELETE FROM stops WHERE train_id = #{self.id()};")
      DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
    end

end
