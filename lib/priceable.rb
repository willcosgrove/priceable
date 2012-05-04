require "priceable/version"

module Priceable
  SUFFIXES = ["_in_cents", "_in_pennies"]
  def priceable(*price_fields)
    price_fields.each do |price_field|
      suffix = SUFFIXES.detect { |suffix| self.attribute_method? "#{price_field}#{suffix}".to_sym }
      raise ArgumentError, "Unable to find valid database field for `#{price_field}'" unless suffix
      define_method price_field do
        send("#{price_field}#{suffix}".to_sym) / 100.0
      end  
      define_method "#{price_field}=".to_sym do |new_price|
        send("#{price_field}#{suffix}=".to_sym, new_price * 100)
      end
    end
    if self._accessible_attributes?
      attr_accessible *price_fields
    end
  end
end

ActiveRecord::Base.send(:extend, Priceable)
