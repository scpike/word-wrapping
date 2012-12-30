$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'word_wrapper'

require 'minitest/autorun'

class WordWrapperTest < MiniTest::Unit::TestCase
  def setup
    @short_text = "Four score and seven years ago our fathers brought forth upon this continent a new nation"
    @med_text = "Four score and seven years ago our fathers brought forth upon this continent a new nation, conceived in liberty and dedicated to the proposition that all men are created equal"
  end

  def test_greedy_costs
    assert_equal 90, WordWrapper::Greedy.new(13, @short_text).cost
    assert_equal 264, WordWrapper::Greedy.new(13, @med_text).cost
  end

  def test_min_raggedness_costs
    assert_equal 74, WordWrapper::MinimumRaggedness.new(13, @short_text).cost
    assert_equal 204, WordWrapper::MinimumRaggedness.new(13, @med_text).cost
  end

  def test_optimal_word
    assert_equal 0, WordWrapper::Greedy.new(13, "A"*13 ).cost
    assert_equal 0, WordWrapper::MinimumRaggedness.new(13, "A"*13 ).cost
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
""", WordWrapper::Greedy.new(13,@med_text).wrap
  end

  def test_minimum_raggedness_output
    assert_equal """Four score
and seven
years ago
our fathers
brought forth
upon this
continent a
new nation,
conceived in
liberty and
dedicated
to the
proposition
that all
men are
created equal
""", WordWrapper::MinimumRaggedness.new(13,@med_text).wrap
  end

  def test_minimum_raggedness_with_large_word
    assert_equal """Before the
law sits a
gatekeeper.
To this
gatekeeper
comes
a man
""", WordWrapper::MinimumRaggedness.new(10, "Before the law sits a gatekeeper. To this gatekeeper comes a man").wrap
  end
end
