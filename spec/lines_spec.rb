require 'spec_helper'

describe 'Line' do
  describe 'initialize' do
    it 'initializes a new line' do
      new_line = Line.new({:name => "15th ST Express"})
      expect(new_line).to be_a Line
    end
  end

  describe 'save' do
    it 'saves a line to the database' do
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      expect(Line.all).to eq [new_line]
    end
  end

  describe '.all' do
    it 'returns an array of all the train lines in the database' do
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      new_line2 = Line.new({:name => "HWY 99 Line"})
      new_line2.save
      expect(Line.all).to eq [new_line, new_line2]
    end
  end

  describe '==' do
    it 'compares two train lines to see if they are the same' do
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      new_line2 = Line.new({:name => "15th ST Express"})
      new_line2.save
      expect(new_line.==(new_line2)).to eq true
    end
  end

  describe '.list_lines' do
    it 'returns all of the lines on a specific station' do
      new_station = Station.new({:name => "15th & Pollock St Station"})
      new_station.save
      new_station2 = Station.new({:name => "Market Plaza"})
      new_station2.save
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      new_line2 = Line.new({:name => "HWY 99 Line"})
      new_line2.save
      new_station.add_station_line(new_line.id)
      new_station.add_station_line(new_line2.id)
      new_station2.add_station_line(new_line.id)
      expect(Line.list_lines(new_station.id)).to eq [new_line, new_line2]
    end
  end

  describe '.search_by_line' do
    it 'searches the database and returns a specific line' do
      new_line = Line.new({:name => "15th ST Express"})
      new_line.save
      new_line2 = Line.new({:name => "HWY 99 Line"})
      new_line2.save
      expect(Line.search_by_line(new_line2.id)).to eq [new_line2]
    end
  end
end
