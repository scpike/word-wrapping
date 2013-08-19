(ns wrap.util-test
  (:use clojure.test
        wrap.util
        [clojure.string :only (trim-newline)]))

(deftest splits-words
  (testing "Splits sentence into words."
    (is (= ["Once" "upon" "a" "time"]
           (words "Once upon a time")))))

(deftest combines-output
  (testing "Combines xs back together"
    (is (= ["Once upon" "a time"]
           (lines-to-text [["Once" "upon"] ["a time"]])))))
