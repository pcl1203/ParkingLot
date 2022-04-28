#!/usr/bin/env ruby

# frozen_string_literal: true

require 'yaml'

CARS_FILENAME = 'parkedcars.yml'
# Storage of the data in YAML
class ParkedCars
  def initialize
    @parked_cars = []
    open
  end

  def open
    @parked_cars = YAML.load_file(CARS_FILENAME) if File.exist?(CARS_FILENAME)
    0
  end

  def save
    File.open(CARS_FILENAME, 'w') do |file|
      file.write(@parked_cars.to_yaml)
    end
  end

  def add_car(plate_num, color, slot)
    car = { plate_number: plate_num, color: color.upcase, slot: slot, time_in: Time.new.strftime('%Y-%m-%d %H:%M:%S') }
    if File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?
      @parked_cars[:Cars].push(car)
    else
      @parked_cars = { Cars: [car] }
    end
    save # save new cars
    puts "#{color} vehicle with plate number '#{plate_num}' parked on slot #{slot}"
    @parked_cars[:Cars].count
  end

  def delete_car(plate_num)
    if File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?     
      @parked_cars[:Cars].each do |car| # Search for car with target plate number and delete
        next if car[:plate_number] != plate_num

        @parked_cars[:Cars].delete(car)
        puts "Vehicle with plate number '#{plate_num}' has left"
        break
      end
      save # save new cars
    end
    @parked_cars[:Cars].count
  end

  def check_car_with_plate_number(plate_num)
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    # Search for car with target plate number
    @parked_cars[:Cars].each do |car|
      next if car[:plate_number] != plate_num

      puts "Vehicle(#{car[:color]}) with plate number '#{plate_num}' is parked on slot #{car[:slot]}"
      break # no need to iterate further if found
    end
  end

  def check_car_with_color(color)
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    found = false
    similar_color_car = []
    # Search for car with target color
    @parked_cars[:Cars].each do |car|
      next if car[:color] != color.upcase

      found = true
      similar_color_car.push([car[:plate_number], car[:slot]])
    end
    # Check if specified color exists
    if found == false
      p "No vehicle parked with color #{color}"
      return 0
    end
    # Display results
    puts similar_color_car[0][0]
    p "Vehicle/s with color #{color}"
    p 'Slot No. | Plate Number '
    similar_color_car.each do |car|
      p "#{car[0]} | #{car[1]}"
    end

    similar_color_car.count
  end
end
