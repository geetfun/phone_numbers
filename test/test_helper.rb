require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'test/unit'
require 'shoulda'

require 'config/environment'
require 'db/schema'
require 'phone_numbers'

class ActiveSupport::TestCase
  def deny(expression)
    assert !expression
  end
end