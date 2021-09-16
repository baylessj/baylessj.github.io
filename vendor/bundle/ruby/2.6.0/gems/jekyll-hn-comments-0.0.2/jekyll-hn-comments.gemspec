lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-hn-comments/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-hn-comments"
  spec.summary       = "Easily link to Blog Post comments on Hacker News"
  spec.description   = "Easily link to Blog Post comments on Hacker News"
  spec.version       = JekyllHNComments::VERSION
  spec.authors       = ["Jonathan Bayless"]
  spec.email         = ["me@jonathanbayless.com"]
  spec.homepage      = "https://github.com/baylessj/jekyll-hn-comments"
  spec.licenses      = ["MIT"]
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|spec|features)/!) }
  spec.require_paths = ["lib"]
  spec.add_dependency "jekyll"
end
