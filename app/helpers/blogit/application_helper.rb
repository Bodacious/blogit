module Blogit
  module ApplicationHelper

    TIMETAG_FORMAT = "%Y-%m-%dT%TZ"

    # Format content using the {Blogit::Configuration#default_parser_class default_parser_class}
    def format_content(content = nil, &block)
      content = capture(&block) if block_given?
      parser = Blogit::configuration.default_parser_class.new(content)
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
    def field(content_or_options={}, options ={}, &block)
      div_with_default_class(:field, content_or_options, options, &block)
    end

    # A helper method for creating a +<div>+ tag with class 'actions'
    # Used for option links and form buttons
    def actions(content_or_options={}, options ={}, &block)
      div_with_default_class(:actions, content_or_options, options, &block)
    end

    # A helper method for creating a +<div>+ tag with class 'login_required'
    # Will only render content if there is a logged in user
    def login_required(content_or_options={}, options ={}, &block)
      if current_blogger and blogit_conf.include_admin_links
        div_with_default_class(:login_required, content_or_options, options, &block)
      end
    end

    # Returns an HTML 5 time tag
    # @param time_object Any Time or DateTime object
    # @param format [String, Symbol] If passed a string will treat as a strftime format.
    #   If passed a symbol will treat as pre-set datetime format.
    def time_tag(time_object, format = nil, options ={})
      # if there's a specified format and it's a string, assume it's an strftime string
      if format && format.is_a?(String)
        time_string = time_object.strftime(format)
        # if there's a specified format and it's a symbol, assume it's a predefined format
      elsif format && format.is_a?(Symbol)
        time_string = time_object.to_s(format)
      else
        time_string = time_object.to_s
      end
      options.merge(datetime: time_object.strftime(TIMETAG_FORMAT))
      content_tag(:time, time_string, options)
    end

    # Can search for named routes directly in the main app, omitting
    # the "main_app." prefix
    def method_missing method, *args, &block
      if main_app_url_helper?(method)
        main_app.send(method, *args)
      else
        super
      end
    end
    def respond_to?(method)
      main_app_url_helper?(method) or super
    end

    private

    def main_app_url_helper?(method)
      Blogit::configuration.inline_main_app_named_routes and
        (method.to_s.end_with?('_path') or method.to_s.end_with?('_url')) and
        main_app.respond_to?(method)
    end

    def div_with_default_class(default_class, content_or_options={}, options={}, &block)
      if block_given?
        content = capture(&block)
        options = content_or_options
      else
        content = content_or_options
      end
      options[:class] = "#{default_class} #{options[:class]}".strip
      content_tag(:div, content, options)
    end

  end
end
