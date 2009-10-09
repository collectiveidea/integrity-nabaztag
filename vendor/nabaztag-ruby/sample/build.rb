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
  together 100 do
    ear :right, 180, :forward
    ear :left, 180, :backward
  end
  length 10 do
    led :middle, :yellow
  end
  # together 10 do
  #     ear :right, 180, :forward
  #     ear :left, 180, :backward
  #   end
  #   together 10 do
  #     ear :right, 25, :forward
  #     ear :left, 25, :backward
  #   end
  #   length 10 do
  #     led :middle, :yellow
  #   end
end
