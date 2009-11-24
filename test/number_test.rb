require 'test_helper'
require 'phone_numbers/number'

class NumberTest < ActiveSupport::TestCase
  context "A Number" do
    setup do
      @phone_number = PhoneNumbers::Number.new("123", :test)
    end
    
    context "whose number matches its format" do
      setup do
        PhoneNumbers.formats[:test].expects(:match).returns(stub("matchdata_stub"))
      end
      
      should("be valid") { assert @phone_number.valid? }
    end # whose number matches its format
    
    context "whose number does not match its format" do
      setup do
        PhoneNumbers.formats[:test].expects(:match).returns(nil)
      end

      should("not be valid") { deny @phone_number.valid? }
    end # whose number does not match its format
  end # A Phone Number
end
