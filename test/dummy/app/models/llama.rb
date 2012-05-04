class Llama < ActiveRecord::Base
  attr_accessible :name

  priceable :price
end
