module HasPhoneNumber
  autoload :Validateable, File.join(File.dirname(__FILE__), "validateable")

  class PhoneNumber
    include Validateable
    
    attr_reader :number
    validates_format_of :number, :with => /^(\(\d{3}\) |\d{3}[- ])\d{3}[- ]?\d{4}$/
    
    def initialize(number)
      @number = number
      @errors = ActiveRecord::Errors.new(self)
    end
  end
end