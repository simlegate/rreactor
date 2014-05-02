module Rreactor
  class Reactor

    def register socket, event
      if event.eql?(:accept_event)
        handler = EventHandler::AcceptorHandler.new socket
      elsif event.eql?(:read_event)
        handler = EventHandler::ReaderHandler.new socket
      end
      @dispatcher.register_handler(handler, socket, event))
    end
  end
end
