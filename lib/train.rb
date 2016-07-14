class Train
  attr_reader(:line, :seats, :id)

  define_method(:initialize) do |attributes|
    @line = attributes.fetch(:line)
    @seats = attributes.fetch(:seats)
    @id = attributes[:id]
  end

  define_method(:==) do |another_train|
    self.line() == another_train.line() &&
    self.seats() == another_train.seats()
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      line = train.fetch('line').to_i()
      seats = train.fetch('seats').to_i()
      id = train.fetch('id').to_i()
      trains.push(Train.new({line: line, seats: seats, id: id}))
    end
    trains
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (line, seats) VALUES (#{@line}, #{@seats}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:update) do |attributes|
    @line = attributes.fetch(:line, @line)
    @seats = attributes.fetch(:seats, @line)
    @id = self.id()
    DB.exec("UPDATE trains SET line = #{@line} WHERE id = #{@id};")
    DB.exec("UPDATE trains SET seats = #{@seats} WHERE id = #{@id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO cities_trains (city_id, train_id) VALUES (#{city_id}, #{@id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities_trains WHERE train_id = #{self.id()}")
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end

  define_singleton_method(:find) do |id|
    found_train = nil
    Train.all().each() do |train|
      if train.id == id
        found_train = train
      end
    end
    found_train
  end

  define_method(:cities) do
    train_cities = []
    results = DB.exec("SELECT city_id FROM cities_trains WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      state = city.first().fetch("state")
      train_cities.push(City.new({name: name, state: state, id: city_id}))
    end
    train_cities
  end
end
