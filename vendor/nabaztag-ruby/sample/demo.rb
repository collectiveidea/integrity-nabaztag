# This file is in UTF-8

#
# This sample assumes that you have a file in your home directory called .nabaztag
# containing the MAC and API token for your device, like this:
#  NABAZTAG_MAC = '00039XXXXXXX'
#  NABAZTAG_TOKEN = '1234XXXXXXXXXXX'
#

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'nabaztag'
load ENV['HOME'] + '/.nabaztag'

nabaztag = Nabaztag.new(NABAZTAG_MAC, NABAZTAG_TOKEN)
nabaztag.choreography! do
  tempo 10
  length 10 do
    led :right, :red
  end
  length 10 do
    led :middle, :yellow
  end
  length 10 do 
    led :right, :off
    led :middle, :off
    led :left, :green
  end
  last_led = :right
  [:red, :orange, :yellow, :green, :blue, :violet].each do |color|
    leds = [:right, :top, :left]
    (0...4).each do |i|
      this_led = leds[i]
      event do
        led this_led, color
        led last_led, :off
        led :bottom, color
      end
      last_led = this_led
    end
  end
end
puts "Ears are at (#{nabaztag.ear_positions[0]}, #{nabaztag.ear_positions[1]})."