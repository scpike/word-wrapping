require_relative '../lib/word_wrapper'

wrapper = WordWrapper::MinimumRaggedness.new(40, File.open(ARGV[0]).read)
wrapper.wrap
puts wrapper.output
