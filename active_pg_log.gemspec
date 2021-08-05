lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_pg_log'

Gem::Specification.new do |spec|
  spec.name          = 'active_pg_log'
  spec.version       = ActivePgLog::VERSION
  spec.authors       = ['Wesley Oliveira']
  spec.email         = ['waejloliveira@gmail.com']

  spec.summary       = 'Gem para log de tabelas via banco de dados PostgreSQL sincronizado com ActiveRecord attributes.'
  spec.description   = 'Gem para log de tabelas.'
  spec.homepage      = 'https://github.com/waejl/active_pg_log.git'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://github.com/waejl/active_pg_log'

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/waejl/active_pg_log'
    spec.metadata['changelog_uri'] = 'https://github.com/waejl/active_pg_log/issues'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = 'bin'
  # spec.executables   = %w[setup console]
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
