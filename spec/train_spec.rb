require('spec_helper')

describe(Train) do
  describe("#line") do
    it('should return the line number') do
      test_train = Train.new({line: 1, seats: 250})
      expect(test_train.line()).to(eq(1))
    end
  end

  describe("#seats") do
    it('should return the number of seats') do
      test_train = Train.new({line: 1, seats: 250})
      expect(test_train.seats()).to(eq(250))
    end
  end

  describe('#==') do
    it('is the same train if it has the same line number and seat number') do
      test_train = Train.new({line: 1, seats: 250})
      test_train2 = Train.new({line: 1, seats: 250})
      expect(test_train).to(eq(test_train2))
    end
  end

  describe('.all') do
    it('should return empty') do
      expect(Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it('should insert train into database table "trains"') do
      test_train = Train.new({line: 1, seats: 250})
      test_train.save()
      expect(Train.all()).to(eq([test_train]))
    end
  end

  describe('#update') do
    it('should update a train from the table "trains"') do
      test_train = Train.new({line: 1, seats: 250})
      test_train.save()
      test_train.update({line: 2, seats: 250})
      expect(test_train.line()).to(eq(2))
    end
  end

  describe('#delete') do
    it('deletes a train from the database') do
      train1 = Train.new({line: 1, seats: 250})
      train1.save()
      train2 = Train.new({line: 3, seats: 300})
      train2.save()
      train2.delete()
      expect(Train.all()).to(eq([train1]))
    end
  end

  describe('.find') do
    it('finds a train from list of trains') do
      train1 = Train.new({line: 1, seats: 250})
      train1.save()
      train2 = Train.new({line: 3, seats: 300})
      train2.save()
      expect(Train.find(train1.id())).to(eq(train1))
    end
  end
end
