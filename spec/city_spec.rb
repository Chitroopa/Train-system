require('spec_helper')

describe (City) do
  describe('#name') do
    it('returns the city name') do
      test_city = City.new({:name => 'Seattle', :id => nil})
      expect(test_city.name()).to(eq('Seattle'))
    end
  end

  describe(".all") do
    it("starts off with no cities") do
      expect(City.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save cities to the database") do
      test_city = City.new({:name => "Seattle", :id => nil})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe("#==") do
    it("is the same city if it has the same name") do
      city1 = City.new({:name => "Seattle", :id => nil})
      city2 = City.new({:name => "Seattle", :id => nil})
      expect(city1).to(eq(city2))
    end
  end

  describe(".find") do
    it("returns a list by its ID") do
      test_city = City.new({:name => "Seattle", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Portland", :id => nil})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq([test_city2]))
    end
  end

  describe("#update") do
    it("lets you update cities in the database") do
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      city.update({:name => "Portland"})
      expect(city.name()).to(eq("Portland"))
    end

    it("lets you add a train to a city") do
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      train1 = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland"} )
      train1.save()
      train2 = Train.new({:name => 'L.A. express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "L.A."} )
      train2.save()
      city.update({:train_ids => [train1.id(), train2.id()]})

      expect(city.trains()).to eq([train1, train2])
    end
  end

  describe("#trains") do
    it("lets you add a train to a city") do
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      train1 = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland"} )
      train1.save()
      train2 = Train.new({:name => 'L.A. express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "L.A."} )
      train2.save()
      city.update({:train_ids => [train1.id(), train2.id()]})

      expect(city.trains()).to eq([train1, train2])
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      city2 = City.new({:name => "Portland", :id => nil})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end
end
