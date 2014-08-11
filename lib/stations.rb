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
end
