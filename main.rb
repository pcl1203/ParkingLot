#!/usr/bin/env ruby

# frozen_string_literal: true

require './parking_lot'
require './constants'

puts 'Parking Lot Ticketing'
finish = 0
created = false
parking_lot = ParkingLot.new
while finish.zero?
  option = gets
  words = option.split(' ')
  next if words.count.zero?

  command = words[0]

  if !created 
    case command
    when 'lot', 'create_parking_lot'
      if created
        puts 'Already initiated'
      elsif words.count >= 2
        parking_lot.create(words[1])
        created = true
      else
        puts "Incomplete Command: #{option}"
      end
      next
    else
      puts 'Try creating parking lots first'
    end
  end

  # ensure that lots are already created
  next if !created

  case command
  when 'park'
    if words.count >= 3
      parking_lot.park(words[1], words[2])
    else
      puts "Incomplete Command: #{option}"
    end
  when 'leave'
    if words.count >= 2
      parking_lot.leave_on_slot(words[1])
    else
      puts "Incomplete Command: #{option}"
    end
  when 'stat', 'status'
    parking_lot.status
  when 'cc', 'cars_with_colour'
    if words.count >= 2
      parking_lot.color_based_status(words[1])
    else
      puts "Incomplete Command: #{option}"
    end
  when 'cpn', 'car_with_platenumber', 'slot_number_for_registration_number'
    if words.count >= 2
      parking_lot.platenumber_based_status(words[1])
    else
      puts "Incomplete Command: #{option}"
    end
  when 'pwc', 'plate_numbers_for_cars_with_colour'
    if words.count >= 2
      parking_lot.plate_num_with_color(words[1])
    else
      puts "Incomplete Command: #{option}"
    end
  when 'end'
    finish = 1
  else
    puts "Invalid Command: #{option}"
  end
end

puts 'Thank you for using Parking Lot Ticketing System'
