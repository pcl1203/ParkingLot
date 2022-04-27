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
end
