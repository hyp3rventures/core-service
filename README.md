# Hyper::Core::Service
Core service for the Hyp3r core API. 
Use this when you have an application that needs backend API communication to Hyp3r core.

## Installation

### Gemfile
```ruby
gem 'hyper-core-service', git: 'git@github.com:hyp3rventures/core-service'
```

### Terminal
```
$ bundle install
```

## Features

### Configuration
`Hyper::Core::Service.configure` accepts a block and allows you to set the following properties:

```ruby
Hyper::Core::Service.configure do |config|
  config.email ='user@example.com'
  config.token = 'YOUR_USER_TOKEN'
  config.host = 'YOUR_HOST'
  config.prefix = 'api prefix' # default 'api'
  config.product = 'engage' # 'engage' or 'visualize'
  config.organization_id = 1 # an integer
end
```

### API Client
`Hyper::Core::Service::Client` is a module that exposes `get` and `post` methods. 
You can include or extend it as you see fit.
These methods return a `Dispatcher` object which gives you a whole bunch of goodies. Most of the time you'll want to just use the `result` method from `Dispatcher` as it contains the serialized results you were looking for.

That said, `Dispatcher` has some useful tools for debugging as well.

* `response` - the actual response object from `Faraday` 
* `request_method` - The HTTP method you used (GET or POST)  
* `endpoint` -  The endpoint you're calling
* `arguments` - Your path arguments array
* `options` - Your parameters hash
* `connection` - The connection object 
* `url` - The full pathname

## Usage

### In the API
You will need to set the configuration values for the lifetime of your request. 

### Models
This gem contains the basic models for interacting with the Hyp3r core api:
* `User`
* `Company`
* `Organization`
* `Venue`
* `Interaction`

This gem uses `ActiveModel::Model` for each of these classes so you can use any of the methods from there. http://api.rubyonrails.org/classes/ActiveModel/Model.html

We will add more models as the need arises.

### Extending models
Simply inherit from the model of choice and add your methods:

```ruby
class Interaction < Hyper::Core::Service::Interaction
  def self.foo
    # class-level stuff 
  end
  
  def bar
    # instance level stuff here
  end
end
```

### Getting an authenticated user
If you have correct configuration values, you can get an authenticaed user with `Hyper::Core::Service::User.authenticate`. 
This will return a user with the properties defined in `core/service/models/user.rb`. 

### Making requests
This is intended to be ActiveRecord-y. You'll get lists using `.all`, filtered lists with `.where`, and individual objects using `.find`:

```ruby
class User < Hyper::Core::Service::User
end

all_users = User.all # List of users
filtered_users = User.where(name: 'Dave') # 
user = User.find(1) # Single user
``` 

Notably, if your model is scoped to another model (`Venue` => `Organization` for example), you must have that model's param included in your search:
```ruby
class Venue < Hyper::Core::Service::Venue
end
class Organization < Hyper::Core::Service::Organization
end

organization = Organization.find(1)
venues = Venue.where(some_search: true) # MissingParamsError
venues = Venue.where(some_search: true, organization_id: 1) # Results
```

## Contributing

### Things we need:

More models, more tests!

### Local development

Add a `.env` file and these keys:

* HYPER_CORE_EMAIL=''
* HYPER_CORE_TOKEN=''
* HYPER_CORE_HOST=''
* HYPER_CORE_PRODUCT=''
* HYPER_CORE_ORGANIZATION_ID=''

Fill them in with your own values, then you can run `bundle exec rake console` and play with the service.

* Follow the Code of Conduct
* Fork or clone the repo
* Create a new branch
* Write and test your code - code-related PRs with no tests will be rejected
* Create a PR

That's it, enjoy.

© 2017 Hyp3r, Inc
