TODO

* [ ] Investigate how SolidQueue::BatchExecution work, refactor views/models accordingly
* [ ] Figure out How to display extra Information about Jobs
* [ ] Handle Binary Fields in QueryForms (disabled fields may not be "form_fields")
* [ ] find solution for fixtures

# solid_taxi

`solid_taxi` is a simple monitoring tool for Rails'
[solid_cable](https://github.com/rails/solid_cable),
[solid_cache](https://github.com/rails/solid_cache) and
[solid_queue](https://github.com/rails/solid_queue).

It is somewhat inspired and influenced by
[mission_control-jobs](https://github.com/rails/mission_control-jobs),
but a with focus of simplicity.

## Usage

Follow these 3 steps. Each step is described in detail below.

1. Install the gem
2. Mount the engine
3. Authenticate `solid_taxi`

Then access it at https://your-application.example.com/solid_taxi (or
at the endpoint that you have configured it in step 2).

### Install the gem

In your Rails project's directory, run:

```bash
bundle add "solid_taxi"
```

### Mount the engine

In your Rails application's routes, mount `solid_taxi`. For example:

```ruby
# ./config/routes.rb

Rails.application.routes.draw do
  mount SolidTaxi::Engine => "/solid_taxi"
end
```

### Authenticate `solid_taxi`

> [!WARNING]
> Take this section seriously. If the authentication is not setup
> properly, `solid_taxi` will be open to the whole wide world.
> Make sure you have authentication, and make sure you test it.

First, generate a initializer file and configure the
`base_controller_class`:

```ruby
# ./config/initializers/solid_taxi.rb

Rails.application.configure do
  SolidTaxi::base_controller_class = "SolidTaxiAdminController"
end
```

Second, create the corresponding controller and add your authentication.

#### Example BasicAuth

```ruby
# ./app/controllers/solid_taxi_admin_controller.rb

class SolidTaxiAdminController < ApplicationController
  http_basic_authenticate_with(
    name: SecureRandom.alphanumeric(32),
    password: SecureRandom.alphanumeric(32)
  )
end
```

#### Example custom authentication

```ruby
# ./app/controllers/solid_taxi_admin_controller.rb

class SolidTaxiAdminController < ApplicationController
  before_action :your_custom_authentication_logic

  private

  def your_custom_authentication_logic
    # ...roll your own, else:

    head :unauthorized
    return
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/lxxxvi/solid_taxi. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected
to adhere to the
[code of conduct](https://github.com/lxxxvi/solid_taxi/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the `solid_taxi` project's codebases, issue
trackers, chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/lxxxvi/solid_taxi/blob/main/CODE_OF_CONDUCT.md).
