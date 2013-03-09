require './lib/station'
require './lib/stop'
require './lib/line'
require 'pg'

DB = PG.connect({:dbname => 'timetable', :host => 'localhost'})


def welcome
  puts "Welcome to the To Do list!"
  admin_menu
end

def admin_menu
  choice = nil
  until choice == 'e'
    puts "Press 1 to add a station, 2 to add a line, 3 to add a stop."
    puts "Press 4 to list all of the stations for a given line."
    puts "Press 5 to list all of the lines that stop at a given station."
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when '1'
      add_station
    when '2'
      add_line
    when '3'
      add_stop
    when '4'
      view_stations_by_line
    when '5'
      view_lines_by_station
    when 'e'

      exit
    else
      invalid
    end
  end
end

def add_station
  puts 'Please enter in a station name:'
  @station = Station.new({'name' => gets.chomp}).save
end

def add_line
  puts 'Please enter in a line name:'
  @line = Line.new({'name' => gets.chomp}).save
end

def view_lines_by_station
  puts "Here is a list of all the stations and their ids:"      
  stations = Station.all
  stations.each {|station| puts "'#{station.id}': '#{station.name}'"}  
  print "Please enter a station id for your list: "
  station_id = gets.chomp.to_i
  station_name = Station.find_by_id({'station_id' => station_id}).first.name
  stops = Stop.list_by_station_id({'station_id' => station_id})
  lines = []
  stops.map {|stop| lines += Line.find_by_id({'line_id' => stop.line_id})}
  if lines.length then puts "Here is a list of all the lines that run through station #{station_name}:" end
  lines.each {|line| puts "'#{line.name}'"}  
end

def view_stations_by_line
  puts "Here is a list of all the lines and their ids:"      
  lines = Line.all
  lines.each {|line| puts "'#{line.id}': '#{line.name}'"}  
  print "Please enter a line id for your list: "
  line_id = gets.chomp.to_i
  line = Line.find_by_id(line_id)
  stations = line.stations
  puts "Here is a list of all the stations that line #{line.name} stops at:"
  stations.each {|station| puts "'#{station.id}': '#{station.name}'"}


  stops = Stop.list_by_line_id({'line_id' => line_id})
  stations = []
  stops.map { |stop| stations += Station.find_by_id({'station_id' => stop.station_id})}
  if stations.length then puts "Here is a list of all the stations that line #{line_name} stops at:" end
  stations.each {|station| puts "'#{station.id}': '#{station.name}'"}  
end

def add_stop
  puts "Here is a list of all the stations and their ids:"
  stations = Station.all
  stations.each {|station| puts "'#{station.id}': '#{station.name}'"}
  puts "Here is a list of all the line and their ids:"
  lines = Line.all
  lines.each {|line| puts "'#{line.id}': '#{line.name}'"}  
  print "Please enter a station id for your stop: "
  station_id = gets.chomp.to_i
  print "Please enter a line id for your stop: "
  line_id = gets.chomp.to_i
  Stop.new({'station_id' => station_id, 'line_id' => line_id}).save
end

def clear_db
  DB.exec("DELETE FROM lines *;")
  DB.exec("DELETE FROM stations *;")
  DB.exec("DELETE FROM stops *;")
end

# clear_db
welcome
