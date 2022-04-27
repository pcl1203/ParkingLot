#!/usr/bin/env ruby

# frozen_string_literal: true

# Parking Lot Class
class ParkingLot 
  def create(lots = 1) # Creating Parking Lots
    lots_to_create = Integer(lots)
    puts "Created #{lots_to_create} lot/s"
    lots_to_create
  rescue StandardError
    puts "Invalid lot number used: #{lots}"
    0
  end
end
