#!/usr/bin/env ruby

# frozen_string_literal: true

# Parking Lot Class
class ParkingLot
  # Creating Parking Lots
  def create(lots = 1)
    @vacantslot = 1
    lots_to_create = Integer(lots)
    puts "Created #{lots_to_create} lot/s"
    lots_to_create
  rescue StandardError
    puts "Invalid lot number used: #{lots}"
    0
  end

  # Park Cars with its platenumber and color
  def park(platenumber, color)
    puts "#{color} vehicle with platenumber #{platenumber} parked on slot #{@vacantslot}"
    @vacantslot += 1
    @vacantslot
  rescue StandardError
    puts 'Car not parked'
    @vacantslot
  end

  # Car Leaving based on slot number
  def leave(slot)
    puts "Vehicle on slot #{slot} has been left"
    slot
  rescue StandardError
    puts 'No car is leaving'
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
