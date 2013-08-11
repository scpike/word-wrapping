require_relative '../lib/word_wrapper'

wrapper = WordWrapper::Greedy.new(40, File.open(ARGV[0]).read)
puts wrapper.wrap.chomp
