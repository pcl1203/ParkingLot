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

  def delete_car_with_plate_number(plate_num)
    ret = 0
    if File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?
      @parked_cars[:Cars].each do |car| # Search for car with target plate number and delete
        next if car[:plate_number] != plate_num

        @parked_cars[:Cars].delete(car)
        puts "Vehicle with plate number '#{plate_num}' has left"
        ret = car[:slot]
        break
      end
      save # save new cars
    end
    ret
  end

  def delete_car_on_slot(slot)
    if File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?
      @parked_cars[:Cars].each do |car| # Search for car with target plate number and delete
        next if car[:slot] != slot

        @parked_cars[:Cars].delete(car)
        puts "Vehicle on slot '#{slot}' has left"
        return slot
      end
      save # save new cars
    end
    slot
  end

  def find_car_with_plate_number(plate_num)
    similar_car = []
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    # Search for car with target plate number
    @parked_cars[:Cars].each do |car|
      next if car[:plate_number] != plate_num

      similar_car.push([car[:plate_number], car[:slot], car[:color]])
    end
    similar_car
  end

  def find_cars_with_color(color)
    similar_car = []
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    # Search for car with target plate number
    @parked_cars[:Cars].each do |car|
      next if car[:color] != color.upcase

      similar_car.push([car[:plate_number], car[:slot], car[:color]])
    end
    similar_car
  end

  def check_car_with_plate_number(plate_num)
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    find_car_with_plate_number(plate_num).each do |car|
      puts "Vehicle(#{car[2]}) with plate number '#{car[0]}' is parked on slot #{car[1]}"
    end

    plate_num
  end

  def check_cars_with_color(color)
    return unless File.exist?(CARS_FILENAME) && !@parked_cars.nil? && !@parked_cars[:Cars].nil?

    # Check if specified color exists
    similar_color_car = find_cars_with_color(color)
    if similar_color_car.nil? || similar_color_car.count.zero?
      p "No vehicle parked with color #{color}"
      return 0
    end
    # Display results
    p "Vehicle/s with color #{color}"
    p 'Slot No. | Plate Number '
    similar_color_car.each do |car|
      p "#{car[0]} | #{car[1]}"
    end

    similar_color_car.count
  end
end
