$: << File.dirname(__FILE__) + '/../lib/'
require 'nabaztag/choreography'
require 'test/unit'

class ChoreographyTest < Test::Unit::TestCase
  
  class Choreography < Nabaztag::Choreography
    attr_reader :messages
  end
  
  def test_should_reproduce_api_example_2
    ch = Choreography.new{
      ear :left, 20, :forward
    }
    assert_equal ['0,motor,1,20,0,0'], ch.messages
  end

  def test_should_reproduce_api_example_3
    ch = Choreography.new{
      length 2 do
        led :middle, 0, 238, 0
      end
      led :left, 250, 0, 0
      led :middle, :off
    }
    assert_equal ['0,led,2,0,238,0','2,led,1,250,0,0','3,led,2,0,0,0'], ch.messages
  end
  
  def test_should_reproduce_api_example_4
    ch = Choreography.new{
      tempo 10
      together 2 do
        ear :left, 20, :forward
        led :middle, 0, 238, 0
      end
      led :left, 250, 0, 0
      led :middle, :off
    }
    assert_equal '10,0,motor,1,20,0,0,0,led,2,0,238,0,2,led,1,250,0,0,3,led,2,0,0,0', ch.build
  end
  
end