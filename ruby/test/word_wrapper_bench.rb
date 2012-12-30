require 'benchmark'
include Benchmark

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'word_wrapper'

@oliver_twist = File.read(File.join(File.dirname(__FILE__), "../../oliver-twist.txt"))
@before_the_law = File.read(File.join(File.dirname(__FILE__), "../../before-the-law.txt"))
@gettysburg =  File.read(File.join(File.dirname(__FILE__), "../../getty-long.txt"))

def run_greedy(text, times=10000)
  g = WordWrapper::Greedy.new(100, text)
  times.times do
    g.compute_wrapping
  end
end

def run_mr(text, times=100)
  g = WordWrapper::MinimumRaggedness.new(100, text)
  times.times do
    g.compute_wrapping
  end
end

puts "Greedy algorithm"
Benchmark.bm do |x|
  x.report("#{@gettysburg.split.length} words x 10000:") { run_greedy(@gettysburg) }
  x.report("#{@before_the_law.split.length} words x 10000:") { run_greedy(@before_the_law) }
  x.report("#{@oliver_twist.split.length} words x 10:")  { run_greedy(@oliver_twist, 10) }
end

puts "\nMinimum Raggedness algorithm"
Benchmark.bm do |x|
  x.report("#{@gettysburg.split.length} words x 10000:") { run_mr(@gettysburg) }
  x.report("#{@before_the_law.split.length} words x 10000:") { run_mr(@before_the_law) }
  x.report("#{@oliver_twist.split.length} words x 10:")  { run_mr(@oliver_twist, 10) }
end
