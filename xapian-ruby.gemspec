require 'yaml'
YAML::ENGINE.yamler='psych' if defined?(YAML::ENGINE)

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name         = %q{easy_xapian-ruby}
  s.version      = "1.5.0"
  s.authors      = ["Gernot Kogler", "Easy Software Ltd."]
  s.summary      = %q{xapian libraries and ruby bindings}
  s.email        = %q{gernot.kogler (at) garaio (dot) com}
  s.homepage     = %q{https://github.com/easysoftware/xapian-ruby}
  s.extensions   = ["Rakefile"]

  s.required_ruby_version     = ">= 2.5.0"
  s.required_rubygems_version = ">= 1.3.6"
  s.metadata['allowed_push_host'] = "https://rubygems.org"

  s.files = Dir.glob("xapian_source/*") + %w(LICENSE README.rdoc CHANGELOG.md Rakefile)

  s.add_dependency "rake", ">= 12.2"
end
