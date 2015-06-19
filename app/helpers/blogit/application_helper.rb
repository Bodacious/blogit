module Blogit
  module ApplicationHelper

    TIMETAG_FORMAT = "%Y-%m-%dT%TZ" 

    # Format content using the {Blogit::Configuration#default_parser_class default_parser_class}
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      parser  = Blogit::configuration.default_parser_class.new(content)
      parser.parsed.html_safe
    end

    # Returns the first error message for an ActiveRecord model instance
    # @param object A model instance to check
    # @param attribute A symbol or string for attribute name to check for
    #   errors
    def errors_on(object, attribute)
      error_message = object.errors[attribute].first
      content_tag(:span, error_message, class: "blogit_error_message") if error_message
    end

    # A helper method for creating a +<div>+ tag with class 'field'
    # Used for separating form fields
    def field(content_or_options = {}, options ={}, &block)
      if block_given?
        options = content_or_options
        content = capture(&block)
      else
        content = content_or_options
      end
      options[:class] = Array(options[:class]) + ["field"]
      content_tag(:div, content, options)
    end

    # A helper method for creating a +<div>+ tag with class 'actions'
    # Used for option links and form buttons
    def actions(content_or_options={}, options ={}, &block)
      if block_given?
        options = content_or_options
        content = capture(&block)
      else
        content = content_or_options
      end
      options[:class] = Array(options[:class]) + ["actions"]
      content_tag(:div, content, options)
    end

  end
  
end