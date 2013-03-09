class Stop
  attr_reader :station_id, :line_id, :id

  def initialize(attributes)
    @station_id = attributes['station_id']
    @line_id = attributes['line_id']
    @id = attributes['id']
  end

  def save
    Stop.from_pg_result(DB.exec("INSERT INTO stops (station_id, line_id) VALUES (#{@station_id}, #{@line_id}) RETURNING *;")).first
  end

  def self.list_by_line_id(id)
    Stop.from_pg_result(DB.exec("SELECT * FROM stops WHERE line_id = #{id}"))
  end

  def self.list_by_station_id(id)
    Stop.from_pg_result(DB.exec("SELECT * FROM stops WHERE station_id = #{id}"))
  end

  def ==(other)
    if self.class != other.class
      false
    else
      self.station_id == other.station_id && self.line_id == other.line_id && self.id == other.id
    end
  end

  def self.all 
    Stop.from_pg_result(DB.exec("SELECT * from stops;"))
  end

  private 

  def self.from_pg_result(pg_result)
    pg_result.inject([]) {|stops, stop_hash| stops << Stop.new(stop_hash)}
  end

end
