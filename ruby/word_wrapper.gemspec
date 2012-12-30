require 'rake'

Gem::Specification.new do |s|
  s.name        = 'word_wrapper'
  s.version     = '1.0.0'
  s.date        = '2012-12-30'
  s.summary     = "Pure ruby word wrapping"
  s.description = "Word wrapping implementation in ruby. Includes a naive greedy algorithm (fast) and Knuth's minimum raggedness algorithm from TeX (slower for long texts)."
  s.authors     = ["Stephen Pike"]
  s.email       = 'scpike@gmail.com'
  s.files       = FileList["lib/*rb",
                           "test/*rb",
                           "Rakefile",
                           "Readme"]
  s.license     = 'BSD',
  s.license_file = 'LICENSE'
  s.homepage    =
    'https://github.com/scpike/word-wrapping/tree/master/ruby'
end
