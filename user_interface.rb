require './lib/lines'
require './lib/stations'
require 'pg'

DB = PG.connect({:dbname => 'trains'})

def header
  system 'clear'
  puts "
     ▀▀█▀▀  █▀▀█  █▀▀█ ▀█▀  █▄  █   █▀▀▀█  █   █  █▀▀▀█ ▀▀█▀▀  █▀▀▀  █▀▄▀█
       █    █▄▄▀  █▄▄█  █   █ █ █   ▀▀▀▄▄  █▄▄▄█  ▀▀▀▄▄   █    █▀▀▀  █ █ █
       █    █  █  █  █ ▄█▄  █  ▀█   █▄▄▄█    █    █▄▄▄█   █    █▄▄▄  █   █

   █▀▀█  █▀▀▄  █▀▄▀█ ▀█▀  █▄  █    █▀▀█  █▀▀█  █▀▀▀█  █▀▀█  █▀▀█  █▀▀█  █▀▄▀█
   █▄▄█  █  █  █ █ █  █   █ █ █    █▄▄█  █▄▄▀  █   █  █ ▄▄  █▄▄▀  █▄▄█  █ █ █
   █  █  █▄▄▀  █   █ ▄█▄  █  ▀█    █     █  █  █▄▄▄█  █▄▄█  █  █  █  █  █   █

  \n\n"
end

def faux_loader
  puts "\n\nChecking credentials:"
  logging_in = ["L", "O", "G", "G", "I", "N", "G", " ", "I", "N", ".", ".", "."]
  logging_in.each do |letter|
    print letter
    sleep 0.1
  end
  sleep 1
  puts "\nWelcome Certified Train System Administrator!"
  sleep 3
  main_menu
end

def main_menu
  header
  puts '1 > Add New Station'
  puts '2 > Add New Train Line'
  puts '3 > View Train Line Info'
  puts '4 > View Station Info'
  puts '5 > List all Stations'
  puts '6 > List all Train Lines'
  puts '7 > Add a Train Line to a Station'
  puts '8 > Exit Program'
  choice = gets.chomp
  case(choice)
  when '1'
    add_station
  when '2'
    add_line
  when '3'
    search_lines
  when '4'
    search_stations
  when '5'
    list_stations
  when '6'
    list_lines
  when '7'
    connect_train_line
  when '8'
    exit
  else
    puts "You have accessed the secret menu... Just kidding. Try again!"
    sleep 3
  end
  main_menu
end

def add_station
  header
  puts "Enter a station name to add:"
  station_name = gets.chomp.capitalize
  new_station = Station.new({:name => station_name})
  new_station.save
  puts "  #{station_name} added!"
  sleep 2
end

def add_line
  header
  puts "Enter a train line name to add:"
  line_name = gets.chomp.capitalize
  new_line = Line.new({:name => line_name})
  new_line.save
  puts "  #{line_name} added!"
  sleep 2
end

def list_stations
  header
  puts "All Stations:"
  stations = Station.all
  stations.each do |station|
    puts "  #{station.id}) #{station.name}"
  end
  puts "\nPress ENTER to continue..."
  gets
end

def list_lines
  header
  puts "All Train Lines:"
  lines = Line.all
  lines.each do |line|
    puts "  #{line.id}) #{line.name}"
  end
  puts "\nPress ENTER to continue..."
  gets
end

def search_stations
  list_stations
  puts "Enter Station ID to search:"
  station_id = gets.chomp.to_i
  results = Line.list_lines(station_id)
  results.each do |result|
    puts "  #{result.name}"
  end
  puts "\nPress ENTER to continue..."
  gets
end

def search_lines
  list_lines
  puts "Enter Line ID to search:"
  line_id = gets.chomp.to_i
  results = Station.list_stations(line_id)
  results.each do |result|
    puts "  #{result.name}"
  end
  puts "\nPress ENTER to continue..."
  gets
end

def connect_train_line
  list_lines
  puts "Enter Line ID to add a station:"
  line_id = gets.chomp.to_i
  line = Line.search_by_line(line_id).first
  list_stations
  puts "Enter Station ID for the #{line.name} to stop at:"
  station_id = gets.chomp.to_i
  station = Station.search_by_station(station_id).first
  station.add_station_line(line.id)
  puts "The #{line.name} will now stop at #{station.name}."
  puts "\nPress ENTER to continue..."
  gets
end
faux_loader
