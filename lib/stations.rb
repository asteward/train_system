class Station
  attr_accessor :id, :name
  def initialize(station_info)
    @id = station_info['id']
    @name = station_info['name']
  end
end
