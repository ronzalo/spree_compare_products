# encoding: UTF-8
# frozen_string_literal: true
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "spree_compare_products"
  s.version     = "3.1.0"
  s.summary     = "Spree compare products"
  s.description = "Spree compare products"
  s.required_ruby_version = ">= 1.9.3"

  s.author = "webgradus"
  # s.email     = 'you@example.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  # s.files       = `git ls-files`.split("\n")
  # s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = "lib"
  s.requirements << "none"

  s.add_dependency "spree_core", ">= 3.1.0", "< 4.0"

  s.add_development_dependency "capybara", "~> 2.1"
  s.add_development_dependency "coffee-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl", "~> 4.2"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "rspec-rails", "~> 2.13"
  s.add_development_dependency "sass-rails"
  s.add_development_dependency "selenium-webdriver"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "sqlite3"
end
