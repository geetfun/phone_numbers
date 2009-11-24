require "phone_numbers/formats"

module PhoneNumbers
  autoload :Validateable, "phone_numbers/validateable"

  class Number
    include Validateable

    attr_reader :entry, :format

    validates_each(:entry) do |record, attr_name, value|
      unless PhoneNumbers.formats[record.format].match(value)
        record.errors.add(attr_name, :invalid, :value => value)
      end
    end

    def initialize(entry, format)
      @entry = entry
      @format = format
      @errors = ActiveRecord::Errors.new(self)
    end
  end
end
