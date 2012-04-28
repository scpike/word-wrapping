require 'minitest/autorun'
require_relative '../greedy'
require_relative '../minimum_raggedness'

class WordWrapperTest < MiniTest::Unit::TestCase
  def setup
    @short_text = "Four score and seven years ago our fathers brought forth upon this continent a new nation"
    @med_text = "Four score and seven years ago our fathers brought forth upon this continent a new nation, conceived in liberty and dedicated to the proposition that all men are created equal"
  end

  def test_greedy_costs
    assert_equal 90, Greedy.new(13, @short_text).cost
    assert_equal 264, Greedy.new(13, @med_text).cost
  end

  def test_min_raggedness_costs
    assert_equal 74, MinimumRaggedness.new(13, @short_text).cost
    assert_equal 204, MinimumRaggedness.new(13, @med_text).cost
  end

  def test_optimal_word
    assert_equal 0, Greedy.new(13, "A"*13 ).cost
    assert_equal 0, MinimumRaggedness.new(13, "A"*13 ).cost
  end

  def test_greedy_output
    assert_equal """Four score
and seven
years ago our
fathers
brought forth
upon this
continent a
new nation,
conceived in
liberty and
dedicated to
the
proposition
that all men
are created
equal
""", Greedy.new(13,@med_text).output
  end

  def test_minimum_raggedness_output
    assert_equal """Four score
and seven
years ago our
fathers
brought forth
upon this
continent a
new nation,
conceived in
liberty and
dedicated to
the
proposition
that all men
are created
equal
""", MinimumRaggedness.new(13,@med_text).output
  end

end
