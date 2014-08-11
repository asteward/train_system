require 'spec_helper'

describe 'Station' do
  describe 'initialize' do
    it 'initializes a new station' do
      new_station = Station.new({:name => "15th & Pollock St Station"})
      expect(new_station).to be_a Station
    end
  end

  describe 'save' do
    it 'saves a station to the database' do
      new_station = Station.new({:name => "15th & Pollock St Station"})
      new_station.save
      expect(Station.all).to eq [new_station]
    end
  end

  describe '.all' do
    it 'returns an array of all the train stations in the database' do
      new_station = Station.new({:name => "15th & Pollock St Station"})
      new_station.save
      new_station2 = Station.new({:name => "Market Plaza"})
      new_station2.save
      expect(Station.all).to eq [new_station, new_station2]
    end
  end
end
