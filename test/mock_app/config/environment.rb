ENV['RAILS_ENV'] ||= 'test'
 
# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '~> 2.2' unless defined? RAILS_GEM_VERSION
 
# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
 
Rails::Initializer.run do |config|
  config.frameworks -= [ :active_resource, :action_mailer, :action_controller, :action_view ]
end