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
require 'readline'

nabaztag = Nabaztag.new(NABAZTAG_MAC, NABAZTAG_TOKEN)
nabaztag_methods = (nabaztag.methods - Object.new.methods).sort
loop do
  cmd = Readline.readline('nabaztag > ', true)
  case cmd
  when /^(exit|quit)$/i 
    exit!
  when /^(help|\?)$/
    puts("Commands:")
    nabaztag_methods.each do |method|
      param_count = nabaztag.method(method).arity
      params = ''
      if param_count > 0
        params = '(' << ('a'..'z').to_a[0,param_count].join(', ') << ')'
      end
      puts("  #{method}#{params}")
    end
  else
    begin
      response = nabaztag.instance_eval(cmd)
      puts("=> #{response.inspect}")
    rescue Exception => ex
      puts("=> Error: #{ex.class}: #{ex.to_s}")
    end
  end
end
