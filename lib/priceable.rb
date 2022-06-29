# frozen_string_literal: true

require "priceable/version"

module Priceable
  SUFFIXES = ["_in_cents", "_in_pennies", "_as_integer"].freeze
  PRICE_REGEX = /[^\d\.]/.freeze
  
  def priceable(*price_fields)
    price_fields.each do |price_field|
      suffix = SUFFIXES.detect { |suffix| attribute_method? "#{price_field}#{suffix}" }
      raise ArgumentError, "Unable to find valid database field for `#{price_field}'" unless suffix
      
      define_method price_field do
        unless send("#{price_field}#{suffix}").nil?
          send("#{price_field}#{suffix}") / 100.0
        else
          0.0
        end
      end
      
      define_method "#{price_field}=" do |new_price|
        new_price = new_price.gsub(PRICE_REGEX, '') if new_price.is_a? String

        send("#{price_field}#{suffix}=", (new_price.to_f * 100).round)
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Priceable)
