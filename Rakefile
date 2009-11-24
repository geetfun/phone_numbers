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
    gemspec.name = "phone_numbers"
    gemspec.summary = "Phone number management in ActiveRecord made easy."
    gemspec.description = "Phone number management in ActiveRecord made easy."
    gemspec.email = "vladimir@andrijevik.net"
    gemspec.homepage = "http://github.com/vandrijevik/phone_numbers/"
    gemspec.authors = ["Vladimir Andrijevik"]
  end
  
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. If you're planning on building gems, you better install it like so: sudo gem install jeweler"
  puts
end