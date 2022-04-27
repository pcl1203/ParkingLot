#!/usr/bin/env ruby

# frozen_string_literal: true

require './parking_lot'

puts 'Parking Lot Ticketing'
finish = 0
parking_lot = ParkingLot.new
while finish.zero?
  option = gets
  words = option.split(' ')
  next if words.count.zero?

  command = words[0]

  case command
  when 'lot'
    parking_lot.create(words[1]) if words.count == 2
  when 'end'
    finish = 1
  else
    puts "Invalid Command: #{option}"
  end
end

puts 'Thank you for using Parking Lot Ticketing System'
