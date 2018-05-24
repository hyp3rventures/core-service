lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyper/core/service/version'

Gem::Specification.new do |spec|
  spec.name     = 'hyper-core-service'
  spec.version  = Hyper::Core::Service::VERSION
  spec.authors  = ['David Shaffer']
  spec.email    = ['dave.shaffer@gmail.com', 'dave@hyp3r.co']

  spec.summary  = 'Core service for the Hyp3r core API'
  spec.homepage = 'https://github.com/hyp3rventures/core/service'
  spec.licenses = ['Nonstandard']

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'dotenv', '~> 2'
  spec.add_development_dependency 'factory_bot', '~> 4.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '0.56.0'
  spec.add_development_dependency 'webmock', '~> 3.0'

  spec.add_dependency 'activemodel', '>= 4.2.6'
  spec.add_dependency 'activesupport', '>= 4.2.6'
  spec.add_dependency 'faraday', '~> 0.15'
end
