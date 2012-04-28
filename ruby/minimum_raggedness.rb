require_relative 'word_wrapper'
class MinimumRaggedness < WordWrapper

  def cost_between(words, i, j)
    @c ||= {}
    @c[[i,j]] ||=
      begin
        cost = @width -
          ((j - i) * OneSpaceWidth ) -
          words[i-1..j-1].inject(0){ |acc, w| acc + w.length } # 0 indexed
        cost = cost >= 0 ? cost**2 : Infinity
      end
  end
  #         o(1, j)                                   if c(1,j) < Inf
  # o(j) =
  #         min[ 1 <= k < j ] ( o(k) + c(k+1, j) )    if c(1,j) == Inf
  #
  def optimal_cost(words, j)
    @o ||= {}
    @o[j] ||=
    begin
      cost = cost_between words, 1, j
      chosen_j = j
      if cost == Infinity
        ks = (1..j-1)
        candidates = ks.collect do |k|
          optimal_cost(words, k) +
            cost_between(words, k + 1, j)
        end
        cost = candidates.min
        k = candidates.index(cost)
      else
      end
      cost
    end
  end

  def cost
    optimal_cost @words.dup, @words.length
  end

  def output
  end
end

if $0 == __FILE__ # from cl
  m =  MinimumRaggedness.new
  puts m.output
  puts "Minimum Raggedness costs #{m.cost}"
end
