OneSpaceWidth = 1
Infinity = 1/0.0
Width = 100

class WordWrapper
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
  #
  def line_cost(line)
    (@width - line.strip.length)**2  # no lines will ever start with whitespace
  end

  def total_cost(paragraph)
    paragraph.split("\n").inject(0){ |acc, line| acc + line_cost(line) }
  end

  def illegal_words
    @words.select{ |word| word.length > @width }
  end
end
