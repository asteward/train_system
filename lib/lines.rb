class Line
  attr_reader :id, :name
  def initialize(line_info)
    @id = line_info['id']
    @name = line_info['name']
  end
end
