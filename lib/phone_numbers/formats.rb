module PhoneNumbers
  @@formats = {}
  
  def self.formats
    @@formats
  end
end

PhoneNumbers.formats.update(:us => /^(\(\d{3}\) |\d{3}[- ])\d{3}[- ]?\d{4}$/)
