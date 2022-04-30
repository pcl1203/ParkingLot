#!/usr/bin/env ruby

# frozen_string_literal: true

require './parked_cars'

# Parking Lot Class
class ParkingLot
  def initialize
    @parked_cars = ParkedCars.new
    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  # Creating Parking Lots
  def create(lots = 1)
    lots_to_create = Integer(lots)
    @open_slot = Array.new(lots_to_create, true)
    puts "Created #{lots_to_create} parking slot"
    lots_to_create
  rescue StandardError
    puts "Invalid lot number used: #{lots}"
    0
  end

  # Determine the lowest open slot
  def determine_open_slot
    @open_slot.find_index(true) + 1
  rescue StandardError
    puts 'No available parking slot'
    0
  end

  # Park Cars with its platenumber and color
  def park(platenumber, color)
    vacant_slot = determine_open_slot
    if vacant_slot.positive?
      @parked_cars.add_car(platenumber, color, vacant_slot)
      @open_slot[vacant_slot - 1] = false
      vacant_slot
    end
  rescue StandardError
    puts 'Car not parked'
    0
  end

  # Car Leaving based on slot number
  def leave_on_slot(slot)
    slot_num = Integer(slot)
    if @open_slot.count < slot_num
      puts 'Invalid slot'
      return 0
    elsif @open_slot[slot_num - 1] == true
      puts 'Already a free slot'
      return 0
    end
    @parked_cars.delete_car_on_slot(slot_num)
    @open_slot[slot_num - 1] = true
    slot
  rescue StandardError
    puts "No car is leaving on slot #{slot_num}"
    0
  end

  # Car Leaving based on plate number
  def leave_with_plate_number(plate_num)
    slot = @parked_cars.delete_car_with_plate_number(plate_num)
    if slot.positive?
      @open_slot[slot - 1] = true
    else
      puts 'No car is leaving'
    end
    slot
  end

  # Get the details of parked cars
  def status
    @parked_cars.show_all_cars
  rescue StandardError
    puts 'No cars parked'
  end

  # Get the details of parked cars based on its color
  def color_based_status(color)
    @parked_cars.check_cars_with_color(color)
  rescue StandardError
    puts "No #{color} cars parked"
    0
  end

  # Get the details of parked cars based on its plate number
  def platenumber_based_status(platenumber)
    @parked_cars.check_car_with_plate_number(platenumber)
  rescue StandardError
    puts "No car with plate number #{platenumber} parked"
    0
  end

  # Get plate numbers of parked cars based on its color
  def plate_num_with_color(color)
    @parked_cars.check_platenum_cars_with_color(color)
  rescue StandardError
    puts "No #{color} cars parked"
    0
  end

end
