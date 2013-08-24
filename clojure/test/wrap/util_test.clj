(ns wrap.util-test
  (:use clojure.test
        wrap.util
        [clojure.string :only (trim-newline)]))

(deftest splits-paragraphs
  (testing "Splits text into paragraphs"
    (is (= ["Once upon\na time." "In a galaxy far far away"]
          (paragraphs "Once upon\na time.\n\nIn a galaxy far far away")))))

(deftest splits-words
  (testing "Splits sentence into words."
    (is (= ["Once" "upon" "a" "time"]
           (words "Once upon a time")))))

(deftest combines-output
  (testing "Combines xs back together"
    (is (= ["Once upon" "a time"]
           (lines-to-text [["Once" "upon"] ["a time"]])))))