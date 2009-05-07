require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'test/unit'
require 'shoulda'

class ActiveSupport::TestCase
  def deny(expression)
    assert !expression
  end
end