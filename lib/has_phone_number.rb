module HasPhoneNumber
  autoload :PhoneNumber, 'has_phone_number/phone_number'

  module ClassMethods
    def has_phone_number(attribute)
      composed_of "#{attribute}_as_phone_number".intern,
                  :class_name => "HasPhoneNumber::PhoneNumber",
                  :mapping => [attribute.to_s, "number"],
                  :allow_nil => true
      
      validates_as_phone_number "#{attribute}_as_phone_number".intern
    end
  
  private
    def validates_as_phone_number(*attr_names)
      configuration = { :on => :save }
      configuration.update(attr_names.extract_options!)
      
      validates_each(attr_names, configuration) do |record, attr_name, value|
        unless value.nil? || value.valid?
          original_attr_name = attr_name.to_s.gsub(/_as_phone_number$/, "").intern
          record.errors.add(original_attr_name, :invalid, :default => configuration[:message], :value => value)
        end
      end
    end
  end # ClassMethods
  
end # HasPhoneNumber

ActiveRecord::Base.class_eval { extend HasPhoneNumber::ClassMethods }