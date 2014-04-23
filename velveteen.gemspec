# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'velveteen/version'

Gem::Specification.new do |spec|
  spec.name          = "velveteen"
  spec.version       = Velveteen::VERSION
  spec.authors       = ["Corey Woodcox"]
  spec.email         = ["corey.woodcox@gmail.com"]
  spec.description   = %q{Velveteen is a simple worker queue library for RabbitMQ.}
  spec.summary       = %q{RabbitMQ is fantastic at managing queues, Velveteen
                          is a basic publisher and consumer library to make
                          worker processes and consuming messages in Rabbit
                          queues as jobs really easy.}
  spec.homepage      = "https://github.com/tanner-labs/velveteen"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~>5.3"
end
