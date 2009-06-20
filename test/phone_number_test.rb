require 'test_helper'
require 'has_phone_number/phone_number'

class PhoneNumberTest < ActiveSupport::TestCase
  context "A Phone Number" do
    setup do
      @phone_number = HasPhoneNumber::PhoneNumber.new("123", :test)
    end
    
    context "whose number matches its format" do
      setup do
        HasPhoneNumber::PhoneNumber.formats[:test].expects(:match).returns(stub("match_stub"))
      end
      
      should("be valid") { assert @phone_number.valid? }
    end # whose number matches its format
    
    context "whose number does not match its format" do
      setup do
        HasPhoneNumber::PhoneNumber.formats[:test].expects(:match).returns(nil)
      end

      should("not be valid") { deny @phone_number.valid? }
    end # whose number does not match its format
  end # A Phone Number
end
