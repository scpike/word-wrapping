OneSpaceWidth = 1
Infinity = 1/0.0
Width = 13

class WordWrapper
  def initialize(width = Width, input = ARGV[0])
    @width = width
    if input
      begin
        @input =  File.read(input)
      rescue Errno::ENOENT => e
        @input = input
      end
      @words = @input.split
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
end
