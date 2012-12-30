Ruby word wrapping implementation
============================================================

This is a pure ruby implementation of word wrapping. Currently supports the Greedy algorithm as well as Knuth's [Minimum Raggedness](http://en.wikipedia.org/wiki/Word_wrap#Knuth.27s_algorithm).

Install:

    gem install word_wrapper

Usage:

    require 'word_wrapper'

    > text = "Before the law sits a gatekeeper. To this gatekeeper comes a man"

    > puts WordWrapper::MinimumRaggedness.new(30, text).wrap

    Before the law sits a
    gatekeeper. To this
    gatekeeper comes a man

    > puts WordWrapper::Greedy.new(30, text).wrap

    Before the law sits a
    gatekeeper. To this gatekeeper
    comes a man

Contributing:

You can run the tests if you have the Minitest gem installed with:

    rake test
