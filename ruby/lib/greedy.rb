class WordWrapper
  class Greedy < WordWrapper
    def wrap
      words = @input.split
      ans = ""
      while words.any?
        line = words.shift
        while words.any? and (line.length + words[0].length) <= @width-1 # room for " "
          line << " " << words.shift
        end
        ans << line << "\n"
      end
      @output = ans
    end

    def cost
      compute_wrapping unless @cost
      @cost
    end

    def compute_wrapping
      @output = wrap
      @cost = total_cost(@output)
    end
  end

  if $0 == __FILE__ # run from cl
    g = Greedy.new
    g.compute_wrapping
    puts g.output
    puts "Greedy costs #{g.cost}"
  end
end
