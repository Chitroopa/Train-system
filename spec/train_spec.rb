require('spec_helper')

describe (Train) do
  describe('#attr_reader') do
    it('returns all the train details') do
      test_train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      expect(test_train.name()).to(eq('Portland express'))
      expect(test_train.departure_time()).to(eq('10:00:00'))
      expect(test_train.departure_location()).to(eq('Seattle'))
      expect(test_train.arrival_time()).to(eq('11:00:00'))
      expect(test_train.arrival_location()).to(eq('Portland'))
      expect(test_train.ticket_price()).to(eq(30))
    end
  end

  describe(".all") do
    it("starts off with no trains") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save trains to the database") do
      test_train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe("#==") do
    it("is the same train if it has the same name") do
      train1 = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train2 = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      expect(train1).to(eq(train2))
    end
  end

  describe(".find") do
    it("returns a list by its ID") do
      test_train = Train.new({:name => 'Seattle express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      test_train.save()
      test_train2 = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train.save()
      train.update({:departure_time => '11:00:00'})
      expect(train.departure_time()).to(eq("11:00:00"))
    end

    it("lets you add a city to the train's route") do
      train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train.save()
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      city2 = City.new({:name => "L.A.", :id => nil})
      city2.save()
      train.update({:city_ids => [city.id(), city2.id()]})

      expect(train.cities()).to eq([city, city2])
    end
  end
  describe('#cities') do
    it("lets you add a city to the train's route") do
      train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train.save()
      city = City.new({:name => "Seattle", :id => nil})
      city.save()
      city2 = City.new({:name => "L.A.", :id => nil})
      city2.save()
      train.update({:city_ids => [city.id(), city2.id()]})

      expect(train.cities()).to eq([city, city2])
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train.save()
      train2 = Train.new({:name => 'Seattle express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland", :ticket_price => 30} )
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end
end
