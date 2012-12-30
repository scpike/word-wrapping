require 'rake'

Gem::Specification.new do |s|
  s.name        = 'word_wrapper'
  s.version     = '0.5.0'
  s.date        = '2012-12-30'
  s.summary     = "Pure ruby word wrapping"
  s.description = "Word wrapping implementation in ruby. Includes a naive greedy algorithm (fast) and Knuth's minimum raggedness algorithm from TeX (slower for long texts)."
  s.authors     = ["Stephen Pike"]
  s.email       = 'scpike@gmail.com'
  s.files       = FileList["lib/*rb",
                           "test/*rb",
                           "samples/*txt",
                           "Rakefile",
                           "README.md",
                           "LICENSE"]
  s.licenses     = ['bsd']
  s.homepage    =
    'https://github.com/scpike/word-wrapping/tree/master/ruby'
  s.add_development_dependency "minitest", [">= 0"]
end
