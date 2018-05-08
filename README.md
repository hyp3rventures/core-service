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

### Getting an authenticated user
If you have correct configuration values, you can get an authenticaed user with `Hyper::Core::Service::User.authenticate`. 
This will return a user with the properties defined in `core/service/models/user.rb`.

### Making requests
This is intended to be ActiveRecord-y. You'll get lists using `.all`, filtered lists with `.where`, and individual objects using `.find`:

```ruby
all_users = Hyper::Core::Service::User.all # List of users
filtered_users = Hyper::Core::Service::User.where(name: 'Dave') # Does not _exactly_ work yet but will shortly
user = Hyper::Core::Service::User.find(1) # Single user
``` 

## Contributing

### Local development

Add a `.env` file and these keys:

HYPER_CORE_EMAIL=''
HYPER_CORE_TOKEN=''
HYPER_CORE_HOST=''
HYPER_CORE_PRODUCT=''
HYPER_CORE_ORGANIZATION_ID=''

Fill them in with your own values, then you can run `bundle exec rake console` and play with the service.

* Follow the Code of Conduct
* Fork or clone the repo
* Create a new branch
* Write and test your code - code-related PRs with no tests will be rejected
* Create a PR

That's it, enjoy.

© 2017 Hyp3r, Inc
