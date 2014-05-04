require 'socket'

require_relative "rreactor/version"
require_relative "rreactor/dispatcher"

require_relative "rreactor/reactor"
require_relative "rreactor/event_handler"

module Rreactor

  class Server
    def initialize ip, port
      @server_socket = TCPServer.new ip, port
      @dispatcher = Dispatcher.new @server_socket
    end

    def start &block
      reactor = Rreactor::Reactor.new(dispatcher)
      reactor.register @server_socket, :accept_event
      $EVENT_ACTION = block if block_given?
      puts 'starting server ....'
      loop do
        @dispatcher.handle_events 
      end
    end

    def stop
      @server_socket.close
    end
  end
end

Rreactor::Server.new("0.0.0.0", 2000).start  do |socket|
  puts socket.gets
end
