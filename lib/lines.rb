class Line
  attr_accessor :id, :name
  def initialize(line_info)
    @id = line_info['id']
    @name = line_info['name']
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
end
