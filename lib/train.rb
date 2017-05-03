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
        departure_time = attributes.fetch('departure_time')
        departure_location = attributes.fetch('departure_location')
        arrival_time = attributes.fetch('arrival_time')
        arrival_location = attributes.fetch('arrival_location')
        trains.push(Train.new({:id => id, :name => name, :departure_time => departure_time, :departure_location=> departure_location, :arrival_time => arrival_time, :arrival_location=> arrival_location}))
      end
      trains
    end
    
end
