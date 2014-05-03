module Rreactor
  class Reactor

    def initialize dispatcher
      @dispatcher = dispatcher
    end

    def register socket, event
      if event.eql?(:accept_event)
        handler = EventHandler::AcceptorHandler.new socket, @dispatcher
      elsif event.eql?(:read_event)
        handler = EventHandler::ReaderHandler.new socket, @dispatcher
      end
      @dispatcher.register_handler(handler, socket, event)
    end
  end
end
