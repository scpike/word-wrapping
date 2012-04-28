require_relative "word_wrapper"

class Greedy < WordWrapper
  def output
    words = @input.split
    ans = ""
    while words.any?
      line = words.shift
      while words.any? and (line.length + words[0].length) <= @width-1 # room for " "
        line << " " << words.shift
      end
      ans << line << "\n"
    end
    ans
  end

  def cost
    total_cost output
  end
end

if $0 == __FILE__ # run from cl
  g = Greedy.new
  puts g.output
  puts "Greedy costs #{g.cost}"
end
