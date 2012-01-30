Gem::Specification.new do |s|
  s.name        = "hook"
  s.authors     = "Matt Parker"
  s.version     = File.read "VERSION"
  s.email       = "moonmaster9000@gmail.com"
  s.homepage    = "http://github.com/moonmaster9000/hook"
  s.summary     = "A simple, lightweight system for adding lifecycle callbacks to your objects."

  s.files = Dir["lib/**/*"] + ["readme.markdown"]
  s.test_files = Dir["specdown/**/*"]
  
  s.add_development_dependency "specdown", "~> 0.4.0.beta.3"
  s.add_development_dependency "rspec"
end
