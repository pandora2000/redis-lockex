Gem::Specification.new do |s|
  s.name = 'redis-lockex'
  s.version = '0.0.1'
  s.authors = ['Tetsuri Moriya']
  s.email = ['tetsuri.moriya@gmail.com']
  s.summary = 'Redis lock extension'
  s.description = 'Redis lock extension with various options'
  s.homepage = 'https://github.com/pandora2000/redis-lockex'
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
  s.add_development_dependency 'rspec', '>= 0'
  s.add_runtime_dependency 'redis', '>= 0'
  s.add_runtime_dependency 'activesupport', '>= 4'
end
