module HasPhoneNumber
  autoload :Validateable, File.join(File.dirname(__FILE__), "validateable")

  class PhoneNumber
    include Validateable
    
    attr_reader :number, :number_format
    validates_format_of :number, :with => /^(\(\d{3}\) |\d{3}[- ])\d{3}[- ]?\d{4}$/
    
    def initialize(number, number_format=nil)
      @number = number
      @number_format = number_format
      @errors = ActiveRecord::Errors.new(self)
    end
  end
end