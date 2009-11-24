require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'test/unit'
require 'shoulda'

require 'mock_app/config/environment'
require 'mock_app/db/schema'

class ActiveSupport::TestCase
  def deny(expression)
    assert !expression
  end
end