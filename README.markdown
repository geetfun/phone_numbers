HasPhoneNumber
==============

HasPhoneNumber makes phone number validations in ActiveRecord easy. Make sure your model
has a string attribute to store your phone number, pass it to `has_phone_number`, and
you're done!

    class Person < ActiveRecord::Base
      has_phone_number :cell_phone
    end

This will ensure that the phone number in `cell_phone` is of a valid phone number
format, and invalidate Person if the phone number is invalid. It will also play
nice with `form_for`, so you can display the errors to your users.

Using Formats
-------------

By default, `has_phone_number` will validate against a US phone number format. For this,
all you need to do is:

    class Person < ActiveRecord::Base
      has_phone_number :cell_phone
    end

If, however you want to validate against a different phone number format, you can:

    class Office < ActiveRecord::Base
      has_phone_number :main, :format => :us
      has_phone_number :abroad, :format => :france
    end

This will validate the `main` attribute against a US number format (included),
and `abroad` against a France number format (if you've specified it).

Specifying Formats
------------------

Format names and specifications are stored in the HasPhoneNumber::PhoneNumber.formats hash.
The key is a symbol (that can be used with the :format option to `has_phone_number`),
and the value is a regex that the attribute is matched against.

In a Rails project, you can specify additional formats a number of ways, but the cleanest is
to put your number formats in an intializer. For example, `config/initializers/phone_number_formats.rb`:

    my_formats = {:my_number_format => /\d{10}/,
                  :no_area_code => /\d{3}-\d{4}/}
    
    HasPhoneNumber::PhoneNumber.formats.update(my_formats)

Hope you like it!

Copyright (c) 2009 [Vladimir Andrijevik], released under the MIT license
