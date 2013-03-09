class Station
  attr_reader :id, :name

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    @id = DB.exec("INSERT INTO stations (name) VALUES ('#{@name}') RETURNING id;").map {|result| result['id']}.first
  end

  def self.all
    Station.from_pg_result(DB.exec("SELECT * FROM stations;"))
  end

  def ==(other)
    if self.class != other.class
      false
    else
      self.name == other.name && self.id == other.id
    end
  end

  def self.find_by_id(id)
    Station.from_pg_result(DB.exec("SELECT * FROM stations WHERE id = #{id}"))
  end

  private

  def self.from_pg_result(pg_result)
    pg_result.inject([]) {|stations, station_hash| stations << Station.new(station_hash)}
  end
end
