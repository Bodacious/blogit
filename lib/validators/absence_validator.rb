module Validators
  # Checks that an attribute is absent. The opposite of Rails's PresenceValidator
  class AbsenceValidator < ActiveModel::EachValidator
    # This is a Rails method for custom Validators. Please read {http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html#method-i-validates_each the Rails docs} for more info
    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid) if value.present?
    end
  end
end
