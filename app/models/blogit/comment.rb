module Blogit
  class Comment < ApplicationRecord
    # require custom validators
    require "validators"
    include Validators

    # ================
    # = Associations =
    # ================

    belongs_to :post, class_name: "Blogit::Post", counter_cache: true, touch: true

    # TODO: Check if this is optimal
    URL_REGEX   = /\A(http|https):\/\/[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z/ix

    # TODO: Check if this is optimal
    EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i

    # =============
    # = Callbacks =
    # =============

    before_validation :format_website

    # ==============
    # = Attributes =
    # ==============

    # nickname acts as a "honeypot" to catch spam
    # the form field should be hidden using CSS and so
    # if present, must be spam.
    #
    # @attribute
    attr_accessor :nickname

    # ===============
    # = Validations =
    # ===============

    # nickname acts as a "honeypot" to catch spam
    # the form field should be hidden using CSS and so
    # if present, must be spam.
    validates :nickname, absence: true
    validates :name, presence: true
    validates :email, presence: true, format: { with: EMAIL_REGEX, allow_blank: true }
    validates :body, presence: true, length: { minimum: 4, allow_blank: true }
    validates :website, format: { with: URL_REGEX, allow_blank: true }

    private

      # Prepend http to the url before the validation check
      def format_website
        if website.present? && website !~ (/^http/i)
          self.website = "http://#{website}"
        end
      end
  end
end
