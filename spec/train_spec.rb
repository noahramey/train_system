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
end
