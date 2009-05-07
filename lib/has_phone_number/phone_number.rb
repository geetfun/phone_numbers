require File.join(File.dirname(__FILE__), "validateable")

module HasPhoneNumber
  class PhoneNumber
    include Validateable
    
    attr_accessor :number
    validates_format_of :number, :with => /^(\(\d{3}\) |\d{3}[- ])\d{3}[- ]?\d{4}$/
  end
end