# Priceable

Easily manage prices in your Rails application

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'priceable'
```

And then execute:

    $ bundle

## Usage

Say you have a model, `Llama`.  You can buy `Llama`s for a `cost`.  Let's add the `cost` to the `Llama` model.

    $ rails g migration add_cost_to_llamas cost_in_cents:integer
    $ rake db:migrate

Now we just need to tell Rails that the `cost` field is priceable

```ruby
# app/models/llama.rb

class Llama < ActiveRecord::Base
  priceable :cost
end
```

And now lets check it out in the console

```ruby
>> llama = Llama.last
>> llama.cost # => nil
>> llama.cost = 100
>> llama.cost_in_cents # => 10000
>> llama.cost # => 100
```

Isn't that special.  So go, and add prices easily to your models, with Priceable. 

PS: `priceable` can take more than one field at a time, so go ahead and load it up like a baked potato.

```ruby
priceable :retail_price, :employee_price, :cost
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
