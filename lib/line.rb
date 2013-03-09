class Line
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    #@id = (DB.exec("INSERT INTO contacts (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}')RETURNING id;").map {|result| result['id']})[0].to_i
    @id =  DB.exec("INSERT INTO lines (name) VALUES ('#{@name}') RETURNING id;").map {|result| result['id']}.first
  end

  def self.all
    Line.from_pg_result(DB.exec("SELECT * FROM lines"))
  end

  def stations
    Stop.list_by_station_id(@id)
  end

  def ==(other)
    if self.class != other.class
      false
    else
      self.name == other.name && self.id == other.id
    end
  end

  def self.find_by_id(id)
    Line.from_pg_result(DB.exec("SELECT * FROM lines WHERE id = #{id}"))
  end

  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) {|lines, line_hash| lines << Line.new(line_hash)}
  end
end
