class Line
  attr_reader :id, :name
  def initialize(line_info)
    @id = line_info['id']
    @name = line_info['name']
  end

  def save
    results = DB.exec("INSERT INTO line (name) VALUES ('#{@name}') RETURNING id;").first
    @id = results['id'].to_i
  end
end
