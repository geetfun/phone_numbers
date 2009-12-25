require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the phone_numbers plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|
    gemspec.add_development_dependency "jeweler",      ">= 1.4.0"
    gemspec.add_development_dependency "mocha",        ">= 0.9.8"
    gemspec.add_development_dependency "shoulda",      ">= 2.10.2"
    gemspec.add_development_dependency "sqlite3-ruby", ">= 1.2.5"

    gemspec.add_runtime_dependency     "activerecord", ">= 2.2"

    gemspec.authors     = ["Vladimir Andrijevik"]
    gemspec.description = "PhoneNumbers simplifies management of phone number attributes in ActiveRecord models."
    gemspec.email       = "vladimir@andrijevik.net"
    gemspec.homepage    = "http://github.com/vandrijevik/phone_numbers/"
    gemspec.name        = "phone_numbers"
    gemspec.summary     = "Phone number management in ActiveRecord made easy."
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Couldn't load jeweler. If you're planning on building gems, you better install it!"
  puts
end