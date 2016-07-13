require('spec_helper')

describe(City) do
  describe("#name") do
    it('should return the city name') do
      test_city = City.new({name: "Jacksonville", state: "FL"})
      expect(test_city.name()).to(eq("Jacksonville"))
    end
  end

  describe("#state") do
    it('should return the number of state') do
      test_city = City.new({name: "Jacksonville", state: "FL"})
      expect(test_city.state()).to(eq("FL"))
    end
  end

  describe('#==') do
    it('is the same city if it has the same name number and seat number') do
      test_city = City.new({name: "Jacksonville", state: "FL"})
      test_city2 = City.new({name: "Jacksonville", state: "FL"})
      expect(test_city).to(eq(test_city2))
    end
  end

  describe('.all') do
    it('should return empty') do
      expect(City.all).to(eq([]))
    end
  end

  describe('#save') do
    it('should insert city into database table "cities"') do
      test_city = City.new({name: "Jacksonville", state: "FL"})
      test_city.save()
      expect(City.all()).to(eq([test_city]))
    end
  end

  describe('#update') do
    it('should update a city from the table "cities"') do
      test_city = City.new({name: "Jacksonville", state: "FL"})
      test_city.save()
      test_city.update({name: "Orlando", state: "FL"})
      expect(test_city.name()).to(eq("Orlando"))
    end
  end

  describe('#delete') do
    it('deletes a city from the database') do
      city1 = City.new({name: "Jacksonville", state: "FL"})
      city1.save()
      city2 = City.new({name: "Orlando", state: "FL"})
      city2.save()
      city2.delete()
      expect(City.all()).to(eq([city1]))
    end
  end

  describe('.find') do
    it('finds a city from list of cities') do
      city1 = City.new({name: "Jacksonville", state: "FL"})
      city1.save()
      city2 = City.new({name: "Orlando", state: "FL"})
      city2.save()
      expect(City.find(city1.id())).to(eq(city1))
    end
  end
end
