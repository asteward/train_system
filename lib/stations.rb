class Station
  attr_accessor :id, :name
  def initialize(station_info)
    @id = station_info['id']
    @name = station_info['name']
  end

  def save
    results = DB.exec("INSERT INTO station (name) VALUES ('#{@name}') RETURNING id;").first
    @id = results['id'].to_i
  end

  def self.all
    stations =[]
    results = DB.exec("SELECT * FROM station;")
    results.each do |result|
      stations << Station.new({:id => result['id'].to_i, :name => result['name']})
    end
    stations
  end

  def ==(another_station)
    self.name == another_station.name
  end

  def add_station_line(line_id)
    DB.exec("INSERT INTO station_line (station_id, line_id) VALUES ('#{self.id}', #{line_id});")
  end

  def self.list_stations(line_id)
    line_stops = []
    results = DB.exec("SELECT station.* FROM
      line JOIN station_line ON (line.id = station_line.line_id)
            JOIN station ON (station_line.station_id = station.id)
      WHERE line.id = #{line_id};")
    results.each do |result|
      line_stops << Station.new({:id => result['id'].to_i, :name => result['name']})
    end
    line_stops
  end

  def self.search_by_station(station_id)
    station = []
    result = DB.exec("SELECT * FROM station WHERE id = #{station_id}").first
    station << Station.new({:id => result['id'].to_i, :name => result['name']})
  end
end
