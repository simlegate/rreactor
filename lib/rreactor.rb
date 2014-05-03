require 'socket'

require_relative "rreactor/version"
require_relative "rreactor/dispatcher"

require_relative "rreactor/reactor"
require_relative "rreactor/event_handler"

module Rreactor

  def self.start ip, port, &block
    @server_socket = TCPServer.new ip, port
    dispatcher = Dispatcher.new @server_socket
    reactor = Rreactor::Reactor.new(dispatcher)
    reactor.register @server_socket, :accept_event
    $EVENT_ACTION = block if block_given?
    puts 'starting server ....'
    loop do
      dispatcher.handle_events 
    end
  end
end

Rreactor.start "0.0.0.0", 2000 do |socket|
  puts socket.gets
end
