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
        unless (cents = send("#{price_field}#{suffix}")).nil?
          cents.fdiv(100)
        end
      end
      
      define_method "#{price_field}=" do |new_price|
        value_to_set =
          case new_price
          when NilClass then nil
          when String
            (new_price.gsub(PRICE_REGEX, '').to_f * 100).round
          else
            (new_price.to_f * 100).round
          end

        send("#{price_field}#{suffix}=", value_to_set)
      end
    end
  end
end

ActiveRecord::Base.send(:extend, Priceable)
