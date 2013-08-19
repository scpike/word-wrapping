class WordWrapper
  class MinimumRaggedness < WordWrapper
    attr_accessor :splits

    # @param [Array<String]] words in the text
    # @param [Integer] i left bound of words to check between
    # @param [Integer] j right bound of words to check between
    # @return [Integer] cost of a line containing the words from i to j
    def cost_between(words, i, j)
      @c ||= {}
      @c[[i,j]] ||=
        begin
          # Special case for single words that are longer than @width.
          # Mark their cost as 0 so they get their own line without
          # messing up the algorithm
          if j == i and words[j-1].length >= @width
            cost = 0
          else
            cost = @width -
              ((j - i) * OneSpaceWidth ) -
              words[i-1..j-1].inject(0){ |acc, w| acc + w.length } # 0 indexed
            cost = cost >= 0 ? cost**2 : Infinity
          end
        end
    end

    # Use dynamic programming to compute the optimal cost of this
    # text.  Recursively calls itself, keeping track of costs found as
    # well as the array of splits required to give that cost (so we
    # can actually generate the optimal text at the end).
    #
    # @param [Array<String>] words to split
    # @param [Intger] j index to compute cost up through, goes from
    #  1..length of words as we recursively compute costs.
    #
    # The evaluation looks like this (o is shorthand for optimal_cost):
    #
    #             -- o(1, j)                                   if c(1,j) < Inf
    #     o(j) = -
    #             -- min[ 1 <= k < j ] ( o(k) + c(k+1, j) )    if c(1,j) == Inf
    #
    # @return [Array<Integer, Array<String>>] (cost, [chain of splits that gives cost])
    def optimal_cost(words, j)
      @o ||= {}
      @o[j] ||=
        begin
          ks = []
          cost = cost_between words, 1, j
          if cost == Infinity and j > 1
            ks = (1..j-1)
            candidates = {}
            ks.collect do |k|
              o = optimal_cost words, k
              c = cost_between words, k + 1, j
              # store both the chain of the child call and k
              candidates[c + o[0]] = [o[1], k]
            end
            if candidates.any?
              cost = candidates.keys.min
              # ks is the chain of splits for this line of recursion
              ks = candidates[cost][0] + [candidates[cost][1]]
            end
          end
          # cost of this line, chain of splits that result in this cost
          [cost,ks]
        end
    end

    def cost
      compute_wrapping unless @cost
      @cost
    end

    def wrap
      compute_wrapping unless @splits
      prev = 0
      ans = ""
      @splits.each do |s|
        ans << @words[prev..s-1].join(" ") << "\n"
        prev = s
      end
      ans << @words[prev..@words.length].join(" ") << "\n"
      ans
    end

    def compute_wrapping
      @words = @input.split
      @cost, @splits = optimal_cost(@words.dup, @words.length)
    end

    def solution?
      cost != Infinity
    end
  end

  if $0 == __FILE__ # from cl
    m =  MinimumRaggedness.new
    m.compute_wrapping
    if m.solution?
      puts m.wrap
      puts "Minimum Raggedness costs #{m.cost}"
    else
      puts "Couldn't wrap the input to #{m.width} characters"
      puts "Possible issues: #{m.illegal_words.join(', ')}"
    end
  end
end
