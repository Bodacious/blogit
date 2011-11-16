module Blogit
  module ApplicationHelper
    
    TIMETAG_FORMAT = "%Y-%m-%dT%TZ"
    
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
      div_with_default_class(:login_required, content_or_options, options, &block) if current_blogger
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
        
    private
    
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
