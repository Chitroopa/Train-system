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

end
