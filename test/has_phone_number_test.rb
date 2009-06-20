require 'test_helper'

class Office < ActiveRecord::Base
  has_phone_number :main
  has_phone_number :abroad, :format => :uk
  has_phone_number :chicago, :boston
  has_phone_number :paris, :lyon, :format => :france
end

class HasPhoneNumberTest < ActiveSupport::TestCase
  context "An object with phone numbers" do
    setup { @office = Office.new }
    
    should "respond to main_as_phone_number" do
      assert_respond_to @office, :main_as_phone_number
    end # respond to main_as_phone_number
    
    should "have a number_formats registry" do
      assert_respond_to Office, :number_formats
    end # have a number_formats registry
    
    should "allow specifying a format for the phone number" do
      assert_equal :uk, Office.number_formats[:abroad]
    end # allow specifying a format for the phone number
    
    should "default the phone number format to :us" do
      assert_equal :us, Office.number_formats[:main]
    end # default the phone number format to :us
    
    should "allow specifying more than one phone number attribute in a single call" do
      assert_respond_to @office, :chicago_as_phone_number
      assert_respond_to @office, :boston_as_phone_number
    end # allow specifying more than one phone number attribute in a single call
    
    should "register the correct format for all phone numbers specified in a single call" do
      assert_equal :france, Office.number_formats[:paris]
      assert_equal :france, Office.number_formats[:lyon]
    end # apply the correct format to all phone numbers specified in a single call
    
    should "validate all phone numbers specified in a single call" do
      @office.lyon = "123"
      @office.lyon_as_phone_number.expects(:valid?)
      
      @office.valid?
    end # validate all phone numbers specified in a single call
    
    context "whose value object is invalid" do
      setup do
        @office.main_as_phone_number = stub(:number => "123", :valid? => false)
      end
      
      should("not be valid") { deny @office.valid? }
      
      should "add an error to the attribute" do
        @office.valid?
        
        assert_nil @office.errors.on(:main_as_phone_number)
        assert_not_nil @office.errors.on(:main)
      end # add an error to the attribute
    end
    
    context "with a nil phone number attribute" do
      should("have a nil corresponding value object") { assert_nil @office.main_as_phone_number }
    end # with a nil phone number attribute
    
    context "with a set phone attribute" do
      setup { @office.main = "1" }
      
      should "have a set value object" do
        assert_kind_of HasPhoneNumber::PhoneNumber, @office.main_as_phone_number
      end
      
      should "set the number of the value object to the value of the phone attribute" do
        assert_equal @office.main, @office.main_as_phone_number.number
      end # set the number of the value object to the value of the phone attribute
      
      should "set the value object to the appropriate number format" do
        assert_equal :us, @office.main_as_phone_number.number_format
      end # set the value object to the appropriate number format
    end # with a set phone attribute
    
    context "with a set value object" do
      setup do
        @office.main_as_phone_number = stub(:number => "123")
      end
      
      should "have an attribute value that matches the number of the value object" do
        assert_equal @office.main_as_phone_number.number, @office.main
      end # have an attribute value that matches the number of the value object
    end # with a set value object
  end # An object with phone numbers
end