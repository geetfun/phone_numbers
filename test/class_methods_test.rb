require 'test_helper'
require 'phone_numbers/class_methods'

class Office < ActiveRecord::Base
  phone_numbers :main
  phone_numbers :abroad, :format => :uk
  phone_numbers :chicago, :boston
  phone_numbers :paris, :lyon, :format => :france
end

class ClassMethodsTest < ActiveSupport::TestCase
  context "An object with phone numbers" do
    setup { @office = Office.new }
    
    should "respond to main_as_phone_number" do
      assert_respond_to @office, :main_as_phone_number
    end # respond to main_as_phone_number
    
    should "allow specifying a format for the phone number" do
      @office.abroad = "123"
      
      assert_equal :uk, @office.abroad_as_phone_number.number_format
    end # allow specifying a format for the phone number
    
    should "default the phone number format to :us" do
      @office.main = "123"
      
      assert_equal :us, @office.main_as_phone_number.number_format
    end # default the phone number format to :us
    
    should "allow specifying more than one phone number attribute in a single call" do
      assert_respond_to @office, :chicago_as_phone_number
      assert_respond_to @office, :boston_as_phone_number
    end # allow specifying more than one phone number attribute in a single call
    
    should "register the correct format for all phone numbers specified in a single call" do
      [:paris, :lyon].each do |phone_number|
        @office.send "#{phone_number}=", "123"
        
        assert_equal :france, @office.send("#{phone_number}_as_phone_number").number_format
      end
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
        assert_kind_of PhoneNumbers::Number, @office.main_as_phone_number
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