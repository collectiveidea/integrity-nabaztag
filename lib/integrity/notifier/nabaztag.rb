require "integrity"
require "nabaztag"
 
module Integrity
  class Notifier
    class Nabaztag < Notifier::Base
      attr_reader :config
 
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end
 
      def deliver!
        nabaztag.say(message) 
        if commit.failed?
          nabaztag.move_ears(10, 10)
        else
          nabaztag.move_ears(0, 0)
        nabaztag.send           
      end
 
    private
      def nabaztag
        @nabaztag ||= Nabaztag.new(config['mac'], config['token'])
      end
 
      def message
        "Build of #{commit.project.name} #{commit.successful? ? "was successful" : "failed"}"
      end
    end
 
    register Nabaztag
  end
end
