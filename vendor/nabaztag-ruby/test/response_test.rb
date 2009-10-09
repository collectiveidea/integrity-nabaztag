$: << File.dirname(__FILE__) + '/../lib/'
require 'nabaztag/response'
require 'test/unit'

class NabaztagResponseTest < Test::Unit::TestCase

  TTS_RESPONSE = '<?xml version="1.0" encoding="UTF-8"?><rsp><message>TTSSEND</message><comment>Your text has been sent</comment></rsp>'
  EAR_RESPONSE = '<rsp><message>POSITIONEAR</message><leftposition>10</leftposition><rightposition>5</rightposition></rsp>'
  
  def test_should_extract_message_from_XML_response
    response = Nabaztag::Response.new(TTS_RESPONSE)
    assert_equal ['TTSSEND'], response.messages
  end

  def test_should_extract_comment_from_XML_response
    response = Nabaztag::Response.new(TTS_RESPONSE)
    assert_equal ['Your text has been sent'], response.comments
  end
  
  def test_should_find_ear_positions_if_supplied
    response = Nabaztag::Response.new(EAR_RESPONSE)
    assert_equal 10, response.left_ear
    assert_equal 5, response.right_ear
  end

  def test_should_return_nil_for_unknown_ear_positions
    response = Nabaztag::Response.new(TTS_RESPONSE)
    assert_nil response.left_ear
    assert_nil response.right_ear
  end
  
end