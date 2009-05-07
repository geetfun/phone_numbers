require 'active_record'
require 'active_record/base'

module Validateable
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include InstanceMethods
      include ActiveRecord::Validations
    end
  end
  
  module ClassMethods
    def self_and_descendants_from_active_record; [self]; end
    def human_name; name.humanize; end
    
    def human_attribute_name(attribute)
      attribute.to_s.titleize
    end
  end # ClassMethods
  
  module InstanceMethods
    [:save, :save!, :update_attribute].each do |method_name|
      define_method(method_name) {}
    end
    
    def method_missing(symbol, *params)
      send($1) if symbol.to_s =~ /(.*)_before_type_cast$/
    end
  end # InstanceMethods
end # Validateable
