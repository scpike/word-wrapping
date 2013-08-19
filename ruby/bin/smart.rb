require_relative '../lib/word_wrapper'

wrapper = WordWrapper::MinimumRaggedness.new(40, File.open(ARGV[0]).read)
puts wrapper.wrap
