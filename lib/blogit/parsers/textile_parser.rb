module Blogit
  module Parsers
    class TextileParser
      require "redcloth"

      # A String containing the content to be parsed
      attr_reader :content

      def initialize(content)
        @content = content
      end

      # The parsed content
      #
      # Returns an HTML safe String
      def parsed
        RedCloth.new(content).to_html
      end
    end
  end
end
