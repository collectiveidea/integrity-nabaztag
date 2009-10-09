# This file is in UTF-8

#
# This sample assumes that you have a file in your home directory called .nabaztag
# containing the MAC and API token for your device, like this:
#  NABAZTAG_MAC = '00039XXXXXXX'
#  NABAZTAG_TOKEN = '1234XXXXXXXXXXX'
#

$KCODE = 'u'
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'nabaztag'
load ENV['HOME'] + '/.nabaztag'
$stdout.sync = true

nabaztag = Nabaztag.new(NABAZTAG_MAC, NABAZTAG_TOKEN)

voice, = ARGV

if voice
  if Nabaztag::VOICES[:en].include?(voice)
    text = 'My name is %s and I speak in English.'
  elsif Nabaztag::VOICES[:fr].include?(voice)
    text = "Je m'appelle %s et je parle en français."
  else
    puts("Unknown voice #{voice}")
  end
  tts = text % voice.sub(/\d+.$/, '').capitalize
  print("Sending '#{tts}' ...")
  nabaztag.voice = voice
  nabaztag.say!(tts)
  puts(" Sent.")
else
  Nabaztag::VOICES.each do |lang, voices|
    voices.each do |voice|
      puts("#{voice} (#{lang})")
    end
  end
end
