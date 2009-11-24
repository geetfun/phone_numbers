module PhoneNumbers
  autoload :Validateable, "phone_numbers/validateable"

  class Number
    include Validateable

    class_inheritable_hash :formats
    self.formats = {:us => /^(\(\d{3}\) |\d{3}[- ])\d{3}[- ]?\d{4}$/}
    
    attr_reader :number, :number_format
    validates_each(:number) do |record, attr_name, value|
      unless record.formats[record.number_format].match(value)
        record.errors.add(attr_name, :invalid, :value => value)
      end
    end
    
    def initialize(number, number_format)
      @number = number
      @number_format = number_format
      @errors = ActiveRecord::Errors.new(self)
    end
  end
end