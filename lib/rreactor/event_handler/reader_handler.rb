module Rreactor
  module EventHandler
    class ReaderHandler
      def initialize socket
        @socket = socket
      end

      def handle_event
        @@event_action.call
      end
    end
  end
end
