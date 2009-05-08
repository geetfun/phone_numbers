require 'test_helper'
require 'has_phone_number/phone_number'

class PhoneNumberTest < ActiveSupport::TestCase
  
  context "A Phone Number" do
    context "whose number contains less than 10 digits" do
      setup { @phone_number = HasPhoneNumber::PhoneNumber.new("(312) 456-789") }
      
      should("not be valid") { deny @phone_number.valid? }
    end # whose number contains less than 10 digits
    
    context "whose number contains more than 10 digits" do
      setup { @phone_number = HasPhoneNumber::PhoneNumber.new("312-456-78901") }
      
      should("not be valid") { deny @phone_number.valid? }
    end # whose number contains more than 10 digits
    
    context "whose number contains 10 digits" do
      context "and also contains characters other than (), - and space" do
        setup { @phone_number = HasPhoneNumber::PhoneNumber.new("a312b456c7890") }
        
        should("not be valid") { deny @phone_number.valid? }
      end # and also contains letters
      
      context "grouped and separated by hyphens" do
        setup { @phone_number = HasPhoneNumber::PhoneNumber.new("312-456-7890") }
        
        should("be valid") { assert @phone_number.valid? }
      end # grouped and separated by hyphens
      
      context "grouped and separated by spaces" do
        setup { @phone_number = HasPhoneNumber::PhoneNumber.new("312 456 7890") }
        
        should("be valid") { assert @phone_number.valid? }
      end # grouped and separated by spaces
      
      context "and the area code is in parentheses" do
        context "followed by a hyphen, and the exchange is followed by a space" do
          setup { @phone_number = HasPhoneNumber::PhoneNumber.new("(312)-456 7890") }
        
          should("not be valid") { deny @phone_number.valid? }
        end # followed by a hyphen, and then space-separated
        
        context "followed by a space, and the exchange is followed by a space" do
          setup { @phone_number = HasPhoneNumber::PhoneNumber.new("(312) 456 7890") }
        
          should("be valid") { assert @phone_number.valid? }
        end # followed by space-separated groups
        
        context "followed by a space, and the exchange is followed by a hyphen" do
          setup { @phone_number = HasPhoneNumber::PhoneNumber.new("(312) 456-7890") }
        
          should("be valid") { assert @phone_number.valid? }
        end # followed by a space, and then hyphen-separated
      end # and the area code is in parentheses
    end # whose number contains 10 digits
  end # A Phone Number
end
