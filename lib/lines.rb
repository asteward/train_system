class Line
  attr_accessor :id, :name
  def initialize(line_info)
    @id = line_info[:id]
    @name = line_info[:name]
  end

  def save
    results = DB.exec("INSERT INTO line (name) VALUES ('#{@name}') RETURNING id;").first
    @id = results['id'].to_i
  end

  def self.all
    lines =[]
    results = DB.exec("SELECT * FROM line;")
    results.each do |result|
      lines << Line.new({:id => result['id'].to_i, :name => result['name']})
    end
    lines
  end

  def ==(another_line)
    self.name == another_line.name
  end

  def self.list_lines(station_id)
    lines = []
    results = DB.exec("SELECT line.* FROM
      station JOIN station_line ON (station.id = station_line.station_id)
            JOIN line ON (station_line.line_id = line.id)
      WHERE station.id = #{station_id};")
    results.each do |result|
      lines << Line.new({:id => result['id'].to_i, :name => result['name']})
    end
    lines
  end

  def self.search_by_line(line_id)
    line = []
    result = DB.exec("SELECT * FROM line WHERE id = #{line_id}").first
    line << Line.new({:id => result['id'].to_i, :name => result['name']})
  end
end
