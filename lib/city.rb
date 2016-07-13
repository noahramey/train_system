class City
  attr_reader(:name, :state, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @state = attributes.fetch(:state)
    @id = attributes[:id]
  end

  define_method(:==) do |another_city|
    self.name() == another_city.name() &&
    self.state() == another_city.state()
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      state = city.fetch('state')
      id = city.fetch('id').to_i()
      cities.push(City.new({name: name, state: state, id: id}))
    end
    cities
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name, state) VALUES ('#{@name}', '#{@state}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @state = attributes.fetch(:state)
    @id = self.id()
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE cities SET state = '#{@state}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    found_city = nil
    City.all().each() do |city|
      if city.id == id
        found_city = city
      end
    end
    found_city
  end
end
