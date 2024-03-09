# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'TEMPLATE-GEM-NAME'
  s.version = ENV.fetch('VERSION', '0')

  s.authors = ['Nathan Ladd']
  s.email = 'nathanladd+github@gmail.com'
  s.homepage = 'https://github.com/test-bench/TEMPLATE-REPO-NAME'
  s.licenses = %w(MIT)
  s.summary = # "Some summary"
  s.platform = Gem::Platform::RUBY

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'

  s.add_development_dependency 'test_bench-isolated'
end
