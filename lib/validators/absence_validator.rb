module Validators

  # Checks that an attribute is absent. 
  # The opposite of PresenceValidator
  class AbsenceValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record.errors.add(attribute, :invalid, options) unless value.blank?
    end

  end

end
