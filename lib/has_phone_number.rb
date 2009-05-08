module HasPhoneNumber
  autoload :PhoneNumber, 'has_phone_number/phone_number'

  module ClassMethods
    def has_phone_number(attribute)
      composed_of "#{attribute}_as_phone_number".intern,
                  :class_name => "HasPhoneNumber::PhoneNumber",
                  :mapping => [attribute.to_s, "number"],
                  :allow_nil => true
    end
  end # ClassMethods
end # HasPhoneNumber

ActiveRecord::Base.class_eval { extend HasPhoneNumber::ClassMethods }