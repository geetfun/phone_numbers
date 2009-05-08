require 'test_helper'

class Person < ActiveRecord::Base
  has_phone_number :cell_phone
end

class HasPhoneNumberTest < ActiveSupport::TestCase
  context "An object of a class that calls has_phone_number" do
    setup do
      @person = Person.new
    end
    
    should 'respond to "#{phone_number_attribute}_as_phone_number"' do
      assert_respond_to @person, :cell_phone_as_phone_number
    end # respond to "#{phone_number_attribute}_as_phone_number"
    
    context "with a nil phone_number_attribute" do
      should 'return nil when responding to "#{phone_number_attribute}_as_phone_number"' do
        assert_nil @person.cell_phone_as_phone_number
      end
    end # with a nil phone_number_attribute
    
    context "with a non-nil phone_number_attribute" do
      setup do
        @person.cell_phone = "1"
      end
      
      should 'return a phone_number when responding to "#{phone_number_attribute}_as_phone_number"' do
        assert_kind_of HasPhoneNumber::PhoneNumber, @person.cell_phone_as_phone_number
      end
      
      should "set the number of the value object to the value of the phone_number_attribute" do
        assert_equal @person.cell_phone, @person.cell_phone_as_phone_number.number
      end # set the number of the value object to the value of the phone_number_attribute
    end # with a non-nil phone_number_attribute
    
    context 'with a non-nil "#{phone_number_attribute}_as_phone_number"' do
      setup do
        @person.cell_phone_as_phone_number = HasPhoneNumber::PhoneNumber.new("123")
      end
      
      should "set the phone_number_attribute to the number of the value object" do
        assert_equal @person.cell_phone_as_phone_number.number, @person.cell_phone
      end # set the phone_number_attribute to the number of the value object
    end # with a non-nil "#{phone_number_attribute}_as_phone_number"
  end # Calling has_phone_number in an ActiveRecord-descendant class
end