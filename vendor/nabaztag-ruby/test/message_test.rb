$: << File.dirname(__FILE__) + '/../lib/'
require 'nabaztag/message'
require 'test/unit'

class NabaztagMessageTest < Test::Unit::TestCase
  
  MAC   = 'ABC123'
  TOKEN = 'DEF456'
  
  class Message < Nabaztag::Message
    public :request_uri
  end
  
  attr_reader :message
  
  def setup
    @message = Message.new(MAC, TOKEN)
  end
  
  def test_should_construct_url_with_mac_and_token
    assert_equal 'http://api.nabaztag.com/vl/FR/api.jsp?sn=ABC123&token=DEF456', message.request_uri
  end
  
  def test_should_escape_parameters_as_utf_8
    message.tts = "équipe"
    assert_match %r!tts=%C3%A9quipe!n, message.request_uri
  end
  
  def test_should_send_actions
    message.action = (:get_timezone)
    assert_match %r!action=4!n, message.request_uri
  end
  
end