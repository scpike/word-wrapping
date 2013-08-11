# Implementation of word wrappign in Ruby. See README for usage.
class WordWrapper
  OneSpaceWidth = 1
  Infinity = 1/0.0
  Width = 100

  attr_accessor :width, :words, :output, :cost
  def initialize(width = Width, text = nil)
    @width = width
    if text
      @input = text
    elsif ARGV[0]
      begin
        @input =  File.read(ARGV[0])
      rescue Errno::ENOENT => e
        @input = ARGV[0]
      end
    else
      raise "You need to supply an input string or file"
    end
  end

  # Calculate the cost of a line. Cost is defined as
  #  [ Trailing whitespace ] ^ 2
  # @param [String] line to compute cost for
  def line_cost(line)
    (@width - line.strip.length)**2  # no lines will ever start with whitespace
  end

  # The total cost of a block of text
  # @param [String] text
  def total_cost(text)
    text.split("\n").inject(0){ |acc, line| acc + line_cost(line) }
  end

  # Any words in the text longer than the width of the output
  # @return [Array<String>] illegal words
  def illegal_words
    @words.select{ |word| word.length > @width }
  end

  def ouput
    @output.to_s.strip
  end
end

require_relative  "minimum_raggedness"
require_relative  "greedy"
