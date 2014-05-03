module Rreactor
  module EventHandler
    class ReaderHandler
      def initialize socket, dispatcher
        @socket, @dispatcher = socket, dispatcher
      end

      def handle_event
        @socket.puts "received"
        $EVENT_ACTION.call(@socket)
      end
    end
  end
end
