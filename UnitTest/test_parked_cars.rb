# frozen_string_literal: true

require 'test/unit'
require_relative '../parked_cars'

CARS_FILENAME = 'parkedcars.yml'
# TestParkedCars
class TestParkedCars < Test::Unit::TestCase
  def setup
    @parked_cars = ParkedCars.new
  end
  test 'open' do
    assert_equal(0, @parked_cars.open)
  end

  test 'add' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'delete' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('d6d', 'white', 2))
    assert_not_equal(0, @parked_cars.delete_car('d6d'))
    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'check_car_with_plate_number' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert(0, @parked_cars.check_car_with_plate_number('dd'))

    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'check_car_with_color' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d3d', 'white', 2))
    assert_not_equal(0, @parked_cars.add_car('d4d', 'white', 3))
    assert_not_equal(0, @parked_cars.check_car_with_color('white'))

    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'check_car_with_color invalid color' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d3d', 'white', 2))
    assert_not_equal(0, @parked_cars.add_car('d4d', 'white', 3))
    assert_equal(0, @parked_cars.check_car_with_color('black'))

    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end
end
