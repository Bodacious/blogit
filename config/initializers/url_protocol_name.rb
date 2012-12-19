module ActionDispatch
  module Http
    module URL
      def protocol_name
        protocol.gsub(/:\/\/$/, "")
      end
    end
  end
end
