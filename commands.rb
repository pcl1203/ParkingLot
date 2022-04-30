#!/usr/bin/env ruby

# frozen_string_literal: true

require './parking_lot'
require './constants'

# Class for routing commands from user
class CommandCatcher
  def initialize
    @continue = true
    @created = false
    @parking_lot = ParkingLot.new
  end

  # returns false if end command is sent
  def check_status
    @continue
  end

  # initiate commands
  def send_command(option)
    words = option.encode('UTF-8', :invalid => :replace).split(' ')
    return if words.count.zero?

    command = words[0]

    if !@created 
      case command
      when 'lot', 'create_parking_lot'
        if @created
          puts 'Already initiated'
        elsif words.count >= 2
          @parking_lot.create(words[1])
          @created = true
        else
          puts "Incomplete Command: #{option}"
        end
        return
      else
        puts 'Try creating parking lots first'
      end
    end

    # ensure that lots are already created
    return if !@created

    case command
    when 'park'
      if words.count >= 3
        @parking_lot.park(words[1], words[2])
      else
        puts "Incomplete Command: #{option}"
      end
    when 'leave'
      if words.count >= 2
        @parking_lot.leave_on_slot(words[1])
      else
        puts "Incomplete Command: #{option}"
      end
    when 'stat', 'status'
      @parking_lot.status
    when 'cc', 'cars_with_colour'
      if words.count >= 2
        @parking_lot.color_based_status(words[1])
      else
        puts "Incomplete Command: #{option}"
      end
    when 'cpn', 'car_with_platenumber', 'slot_number_for_registration_number'
      if words.count >= 2
        @parking_lot.platenumber_based_status(words[1])
      else
        puts "Incomplete Command: #{option}"
      end
    when 'pwc', 'plate_numbers_for_cars_with_colour'
      if words.count >= 2
        @parking_lot.plate_num_with_color(words[1])
      else
        puts "Incomplete Command: #{option}"
      end
    when 'end'
      @continue = false
    else
      puts "Invalid Command: #{option}"
    end
  end
end
