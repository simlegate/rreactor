module Rreactor
  class Dispatcher

    def initialize socket
      @server_socket = socket
      @sockets = Array(socket)

      @event_handlers = {
        :accept_event => {},
        :read_event => {},
        :close_event => {}
      }
    end

    def register_handler event_handler, socket, event
      @event_handlers[event][socket] = event_handler
    end

    def remove_handler event_handler, socket
      @event_handlers[:read_event].delete(socket)
      @event_handlers[:close_event].delete(socket)
      # @sockets.delete(socket)
    end

    def handle_events
      r = IO.select(@sockets)[0]
      r.each do |socket|
        event_type = determine_event_type(socket)
        handler = @event_handlers[event_type][socket]
        handler.handle_event
      end
    end

    def determine_event_type(socket)
      if socket == @server_socket
        :accept_event
      elsif socket.eof?
        :close_event
      else
        :read_event
      end
    end
  end
end
