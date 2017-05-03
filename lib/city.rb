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
    found_city = City.all().select{|city| city.id() == id }
    return found_city
    # found_city = nil
    # City.all().each() do |city|
    #   if city.id() == id
    #     found_city = city
    #   end
    # end
    # found_city
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @id = self.id()
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end
  
end
