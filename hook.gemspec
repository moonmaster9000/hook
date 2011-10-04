Gem::Specification.new do |s|
  s.name        = "hook"
  s.authors     = "Matt Parker"
  s.version     = File.read "VERSION"
  s.email       = "moonmaster9000@gmail.com"
  s.homepage    = "http://github.com/moonmaster9000/hook"
  s.description = "A system for creating view hooks."
  s.summary     = "Add view hooks to your engines."

  s.files = Dir["lib/**/*"] 
  s.test_files = Dir["features/**/*"]
end
