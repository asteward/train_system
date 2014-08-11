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
  puts "Checking credentials:"
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
  puts '3 > Find Stations on a Train Line'
  puts '4 > Find Lines that stop at a particular Station'
  puts '5 > Exit Program'
  choice = gets.chomp
  case(choice)
  when '1'
    add_station
  when '2'
    add_line
  when '3'
    search_by_line
  when '4'
    search_by_station
  when '5'
    exit
  else
    puts "You have accessed the secret menu... Just kidding. Try again!"
    sleep 3
  end
  main_menu
end

faux_loader
