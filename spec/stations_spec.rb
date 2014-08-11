require 'spec_helper'

describe 'Station' do
  describe 'initialize' do
    it 'initializes a new station' do
      new_station = Station.new({:name => "15th & Pollock St Station"})
      expect(new_station).to be_a Station
    end
  end
end
