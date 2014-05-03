module Rreactor
  module EventHandler
    class AcceptorHandler
      def initialize socket, dispatcher
        @socket, @dispatcher = socket, dispatcher
      end

      def handle_event
        client_socket = @socket.accept
        Rreactor::Reactor.new(@dispatcher).register client_socket, :read_event
        Rreactor::Reactor.new(@dispatcher).register client_socket, :close_event
      end
    end
  end
end
