#!/usr/bin/env ruby

# frozen_string_literal: true

require './parked_cars'

# Parking Lot Class
class ParkingLot
  def initialize
    @parked_cars = ParkedCars.new
  end

  # Creating Parking Lots
  def create(lots = 1)
    @open_slot = Array.new(lots, true)
    lots_to_create = Integer(lots)
    puts "Created #{lots_to_create} lot/s"
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
    if @open_slot.count <= slot || @open_slot[slot - 1] == true
      puts 'Invalid slot'
      return 0
    end
    @parked_cars.delete_car_on_slot(slot)
    @open_slot[slot - 1] = true
    slot
  rescue StandardError
    puts 'No car is leaving'
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
    puts "#{color} vehicle with platenumber #{platenumber} on slot #{slot} has been left"
  rescue StandardError
    puts 'No cars parked'
  end

  # Get the details of parked cars based on its color
  def color_based_status(color)
    platenumber = 'ABC-123'
    parked_on_slot = 0
    puts "#{color} vehicle with platenumber #{platenumber} on slot #{slot} has been left"
    [platenumber, parked_on_slot]
  rescue StandardError
    puts "No #{color} cars parked"
    [platenumber, parked_on_slot]
  end

  # Get the details of parked cars based on its plate number
  def platenumber_based_status(platenumber)
    color = 'white'
    parked_on_slot = 0
    puts "#{color} vehicle with platenumber #{platenumber} on slot #{slot} has been left"
    [color, parked_on_slot]
  rescue StandardError
    puts "No car with plate number #{platenumber} parked"
    [color, parked_on_slot]
  end
end
