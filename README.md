# Hyper::CoreService
Core service for the Hyp3r core API. 
Use this when you have an application that needs a full, authenticated user object.

## Usage

### Gemfile
`gem 'hyper-core_service', git: 'git@github.com:hyp3rventures/core_service'`

### Terminal
`$ bundle install`

### Code
```ruby
require 'hyper/core_service'

user_hash = { :email => 'user@example.com', :core_token => 'bzzz' }
service = Hyper::CoreService.new

## You may also configure your own base url and path with a block
service = Hyper::CoreService.new do |config|
  config.base = 'http://myurl.com'
  config.path = '/api/orders/66/execute'
end

response = service.run(user_hash)
authenticated_user = JSON.parse(response.body)
```

You also have access to the response object via `Request#response`.

## Contributing

* Follow the Code of Conduct
* Fork or clone the repo
* Create a new branch
* Write and test your code - code-related PRs with no tests will be rejected
* Create a PR

That's it, enjoy.

© 2017 Hyp3r, Inc
