# -*- encoding: utf-8 -*-
# stub: jekyll-hn-comments 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-hn-comments".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonathan Bayless".freeze]
  s.date = "2020-08-26"
  s.description = "Easily link to Blog Post comments on Hacker News".freeze
  s.email = ["me@jonathanbayless.com".freeze]
  s.homepage = "https://github.com/baylessj/jekyll-hn-comments".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Easily link to Blog Post comments on Hacker News".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jekyll>.freeze, [">= 0"])
    else
      s.add_dependency(%q<jekyll>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<jekyll>.freeze, [">= 0"])
  end
end
