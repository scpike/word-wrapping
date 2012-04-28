require_relative 'word_wrapper'
class MinimumRaggedness < WordWrapper
  def initialize(*args)
    @splits = []
    super
  end
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
  # Returns [ cost, [chain] ]
  def optimal_cost(words, j)
    @o ||= {}
    @o[j] ||=
    begin
      ks = []
      cost = cost_between words, 1, j
      if cost == Infinity
        ks = (1..j-1)
        candidates = {}
        ks.collect do |k|
          o = optimal_cost(words, k)
          c = cost_between(words, k + 1, j)
          candidates[c + o[0]] = [o[1], k]
        end
        cost = candidates.keys.min
        ks = candidates[cost][0] + [candidates[cost][1]]
      else
      end
      [cost,ks]
    end
  end

  def cost
    optimal_cost(@words.dup, @words.length)[0]
  end

  def output
    splits = optimal_cost(@words.dup, @words.length)[1]
    prev = 0
    ans = ""
    splits.uniq.each do |s|
      ans << @words[prev..s-1].join(" ") << "\n"
      prev = s
    end
    ans << @words[prev..@words.length].join(" ") << "\n"
    ans
  end
end

if $0 == __FILE__ # from cl
  m =  MinimumRaggedness.new
  puts m.output
  puts "Minimum Raggedness costs #{m.cost}"
end

