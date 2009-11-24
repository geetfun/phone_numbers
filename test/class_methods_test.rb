require "test_helper"
require "phone_numbers/class_methods"

class ClassMethodsTest < ActiveSupport::TestCase
  context "ActiveRecord::Base" do
    should "have a phone_numbers macro" do
      assert_respond_to ActiveRecord::Base, :phone_numbers
    end
    
    should "have a phone_number macro" do
      assert_respond_to ActiveRecord::Base, :phone_number
    end
  end
  
  class Office < ActiveRecord::Base
    phone_numbers :main
    phone_numbers :abroad, :format => :uk
    phone_numbers :chicago, :boston
    phone_numbers :paris, :lyon, :format => :france
  end
  
  context "An Office" do
    setup { @office = Office.new }
    
    should "respond to main_as_phone_number" do
      assert_respond_to @office, :main_as_phone_number
    end # respond to main_as_phone_number
    
    should "allow specifying a format a the phone number" do
      @office.abroad = "123"
      
      assert_equal :uk, @office.abroad_as_phone_number.number_format
    end # allow specifying a format a the phone number
    
    should "default a phone number's format to :us" do
      @office.main = "123"
      
      assert_equal :us, @office.main_as_phone_number.number_format
    end # default a phone number's format to :us
    
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
      [:paris, :lyon].each do |phone_number|
        @office.send "#{phone_number}=", "123"
        @office.send("#{phone_number}_as_phone_number").expects(:valid?)
      end
      
      @office.valid?
    end # validate all phone numbers specified in a single call
    
    context "with a nil string attribute" do
      should("have a corresponding nil value object") { assert_nil @office.main_as_phone_number }
    end # with a nil string attribute
    
    context "with a set string attribute" do
      setup { @office.main = "1" }
      
      should "have a set value object" do
        assert_kind_of PhoneNumbers::Number, @office.main_as_phone_number
      end
      
      should "set the number of the value object to the string attribute" do
        assert_equal @office.main, @office.main_as_phone_number.number
      end # set the number of the value object to the string attribute
      
      should "set the value object to the appropriate number format" do
        assert_equal :us, @office.main_as_phone_number.number_format
      end # set the value object to the appropriate number format
    end # with a set phone attribute
    
    context "with a set value object" do
      setup { @office.main_as_phone_number = stub(:number => "123") }
      
      should "have a string attribute equal to the number of the value object" do
        assert_equal @office.main_as_phone_number.number, @office.main
      end # have a string attribute equal to the number of the value object
      
      context "that is invalid" do
        setup { @office.main_as_phone_number.stubs(:valid? => false) }
        
        should("not be valid") { deny @office.valid? }
        
        should "have an error on the string attribute only" do
          @office.valid?
          
          assert_nil @office.errors.on(:main_as_phone_number)
          assert_not_nil @office.errors.on(:main)
        end # have an error on the string attribute only
      end # that is invalid
    end # with a set value object
  end # An Office
end