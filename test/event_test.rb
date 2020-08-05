require './lib/item'
require './lib/food_truck'
require './lib/event'
require 'minitest/autorun'
require 'minitest/pride'

class EventTest <  Minitest::Test
  def test_it_exists
    event = Event.new("South Pearl Street Farmers Market")
    assert_instance_of Event, event
  end
end
