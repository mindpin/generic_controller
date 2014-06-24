# GenericController

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'generic_controller'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install generic_controller

## Usage

```ruby
class SomeController < ActionController::Base
  include GenericController

  # set main model and default parameter keys white list for rails' strong parameter
  set_model ModelClass, :allow_attrs => [:attr1, :attr2, {:acc1_ids => []}]

  extra_params = {
    :field1 => proc {current_user.field1},
    :field2 => ->(context) {current_user.field2}
  }

  update_with(extra_params) {redirect_to "/path/to/#{@model_class.id}"}
  destroy_with {redirect_to "/path/to/model_class_index"}
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/generic_controller/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
