require "priceable/version"

module Priceable
  def priceable(*price_fields)
    price_fields.each do |price_field|
      define_method price_field do
        send("#{price_field}_in_cents".to_sym) / 100.0
      end  
      define_method "#{price_field}=".to_sym do |new_price|
        send("#{price_field}_in_cents=".to_sym, new_price * 100)
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Priceable)
