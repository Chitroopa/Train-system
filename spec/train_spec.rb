require('spec_helper')

describe (Train) do
  describe('#attr_reader') do
    it('returns all the train details') do
      test_train = Train.new({:name => 'Portland express', :id => nil, :departure_time => '10:00:00', :departure_location => "Seattle", :arrival_time => '11:00:00', :arrival_location => "Portland"} )
      expect(test_train.name()).to(eq('Portland express'))
      expect(test_train.departure_time()).to(eq('10:00:00'))
      expect(test_train.departure_location()).to(eq('Seattle'))
      expect(test_train.arrival_time()).to(eq('11:00:00'))
      expect(test_train.arrival_location()).to(eq('Portland'))
    end
  end
  
end
