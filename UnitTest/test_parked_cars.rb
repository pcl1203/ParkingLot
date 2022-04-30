# frozen_string_literal: true

require 'test/unit'
require_relative '../parked_cars'

# TestParkedCars
class TestParkedCars < Test::Unit::TestCase
  def setup
    @parked_cars = ParkedCars.new
    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'open' do
    assert_equal(0, @parked_cars.open)
  end

  test 'add' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
  end

  test 'delete_car_with_plate_number' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d6d', 'white', 2))
    assert_equal(2, @parked_cars.delete_car_with_plate_number('d6d'))
    assert_equal(1, @parked_cars.delete_car_with_plate_number('dd'))
  end

  test 'delete_car_with_slot' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d6d', 'white', 2))
    assert_equal(2, @parked_cars.delete_car_on_slot(2))
    assert_equal(1, @parked_cars.delete_car_on_slot(1))
  end

  test 'check_car_with_plate_number' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_equal(1, @parked_cars.check_car_with_plate_number('dd'))
  end

  test 'check_car_with_plate_number invalid' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_equal(0, @parked_cars.check_car_with_plate_number('ddwer'))
  end

  test 'find_car_with_plate_number' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(nil, @parked_cars.find_car_with_plate_number('dd'))
  end

  test 'find_car_with_plate_number invalid' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_equal([], @parked_cars.find_car_with_plate_number('123123'))
  end

  test 'find_cars_with_color' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_not_equal(nil, @parked_cars.find_cars_with_color('white'))
  end

  test 'find_cars_with_color invalid' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 3))
    assert_equal([], @parked_cars.find_cars_with_color('black'))
  end

  test 'check_cars_with_color' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d3d', 'white', 2))
    assert_not_equal(0, @parked_cars.add_car('d4d', 'white', 3))
    assert_not_equal(0, @parked_cars.add_car('d4sd', 'red', 4))
    assert_not_equal(0, @parked_cars.check_cars_with_color('white'))
  end

  test 'check_cars_with_color invalid color' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d3d', 'white', 2))
    assert_not_equal(0, @parked_cars.add_car('d4d', 'white', 3))
    assert_equal(0, @parked_cars.check_cars_with_color('black'))
  end

  test 'show_all_cars' do
    assert_not_equal(0, @parked_cars.add_car('dd', 'white', 1))
    assert_not_equal(0, @parked_cars.add_car('d3d', 'white', 2))
    assert_not_equal(0, @parked_cars.add_car('d4d', 'white', 3))
    assert_equal(3, @parked_cars.show_all_cars)
  end

  test 'show_all_cars invalid' do
    assert_equal(0, @parked_cars.show_all_cars)
  end
end
