# -*- encoding: utf-8 -*-

Gem::Specification.new do |spec|
  spec.name = %q{has_phone_number}
  spec.version = "1.1"

  spec.authors = ["Vladimir Andrijevik"]
  spec.date = %q{2009-06-21}
  spec.description = %q{HasPhoneNumber makes validations for US phone numbers in ActiveRecord models easy.}
  spec.email = %q{vladimir@andrijevik.net}
  spec.homepage = %q{http://github.com/vandrijevik/has_phone_number/}
  spec.summary = %q{a phone number validator for ActiveRecord}

  spec.files = ["has_phone_number.gemspec",
                "has_phone_number/phone_number.rb",
                "has_phone_number/validateable.rb",
                "has_phone_number.rb",
                "MIT-LICENSE",
                "Rakefile",
                "README.markdown"]

  spec.test_files = ["test/config/boot.rb",
                     "test/config/database.yml",
                     "test/config/environment.rb",
                     "test/config/environments/test.rb",
                     "test/config/routes.rb",
                     "test/has_phone_number_test.rb",
                     "test/phone_number_test.rb",
                     "test/test_helper.rb",
                     "test/us_test.rb"]
end
