require File.expand_path("../lib/ogg/version", __FILE__)

Gem::Specification.new "ogg", Ogg::VERSION do |s|
  s.description      = "Ogg is an Open Graph Generator."
  s.summary          = s.description
  s.author           = "namusyaka"
  s.email            = "namusyaka@gmail.com"
  s.homepage         = "https://github.com/namusyaka/ogg"
  s.files            = `git ls-files`.split("\n") - %w(.gitignore)
  s.test_files       = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
  s.license          = "MIT"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-html-matchers"
end

