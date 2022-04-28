# frozen_string_literal: true

require 'test/unit'
require_relative  '../parking_lot'

# TestParkingLot
class TestParkingLot < Test::Unit::TestCase
  def setup
    @parking_lot = ParkingLot.new
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
    assert_equal(2, @parking_lot.park('abc-123', 'black'))
    assert_equal(3, @parking_lot.park('hbc-122', 'white'))
  end

  test 'leaving car' do
    assert_equal(3, @parking_lot.create(3))
    assert_equal(1, @parking_lot.leave(1))
  end

  test 'color_based_status' do
    ret = @parking_lot.color_based_status(black)
    assert_equal('ABC-123', ret[0])
    assert_equal(0, ret[1])
  end

  test 'platenumber_based_status' do
    ret = @parking_lot.platenumber_based_status('ABC-123')
    assert_equal('white', ret[0])
    assert_equal(0, ret[1])
  end
end
