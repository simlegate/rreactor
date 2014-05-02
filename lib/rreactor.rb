require "rreactor/version"
require "rreactor/dispatcher"

module Rreactor

  @@event_action = nil

  def self.start ip, port
    @server_socket = TCPServer.new ip, port
    dispatcher = Dispatcher.new @server_socket
    reactor = Rreactor::Reactor.new
    reactor.register @server_socket, :accept_event
    @@event_action = &block if block_given?
    loop { dispatcher.handle_events }
  end
end
