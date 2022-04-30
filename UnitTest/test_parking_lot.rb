# frozen_string_literal: true

require 'test/unit'
require_relative '../parking_lot'

# TestParkingLot
class TestParkingLot < Test::Unit::TestCase
  def setup
    @parking_lot = ParkingLot.new
  end

  def teardown
    File.delete(CARS_FILENAME) if File.exist?(CARS_FILENAME)
  end

  test 'create parking lot' do
    assert_equal(2, @parking_lot.create(2))
    assert_equal(3, @parking_lot.create(3))
  end

  test 'invalid create parking lot' do
    assert_equal(0, @parking_lot.create('a'))
    assert_equal(0, @parking_lot.create('.././,'))
  end

  test 'park' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(2, @parking_lot.park('hbc-122', 'white'))
  end

  test 'leaving car using slot number' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(1, @parking_lot.leave_on_slot(1))
  end

  test 'invalid slot' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(0, @parking_lot.leave_on_slot(5))
  end

  test 'freeing slot already vacant' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(1, @parking_lot.leave_on_slot(1))
    assert_equal(0, @parking_lot.leave_on_slot(1))
  end

  test 'color_based_status' do
    ret = @parking_lot.color_based_status('black')
    assert_equal('ABC-123', ret[0])
    assert_equal(0, ret[1])
  end

  test 'platenumber_based_status' do
    ret = @parking_lot.platenumber_based_status('ABC-123')
    assert_equal('white', ret[0])
    assert_equal(0, ret[1])
  end

  test 'determine_open_slot' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.determine_open_slot)
  end

  test 'exceeded determine_open_slot' do
    assert_equal(2, @parking_lot.create(2))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(2, @parking_lot.park('hbc-122', 'white'))
    assert_equal(nil, @parking_lot.park('hbc-132', 'red'))
  end

  test 'parking on slot that was previously parked' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(1, @parking_lot.leave_on_slot(1))
    assert_equal(1, @parking_lot.park('dfs-123', 'white'))
    assert_equal(1, @parking_lot.leave_on_slot(1))
    assert_equal(0, @parking_lot.leave_on_slot(1))
  end

  test 'leaving car using plate number' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(1, @parking_lot.leave_with_plate_number('abc-123'))
  end

  test 'invalid plate number' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(0, @parking_lot.leave_with_plate_number('dfgdfg'))
  end

  test 'freeing already vacant using plate number' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.park('abc-123', 'black'))
    assert_equal(1, @parking_lot.leave_with_plate_number('abc-123'))
    assert_equal(0, @parking_lot.leave_with_plate_number('abc-123'))
  end
end
