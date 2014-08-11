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
end
