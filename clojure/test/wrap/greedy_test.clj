(ns wrap.greedy-test
  (:use clojure.test
        wrap.greedy
        [clojure.string :only (trim-newline)]
        [clojure.java.io :as io]))

(def input-dir "../test/input/")
(def greedy-dir "../test/greedy/")

(deftest splits-words
  (testing "Splits sentence into words."
    (is (= ["Once" "upon" "a" "time"]
           (words "Once upon a time")))))

(deftest combines-output
  (testing "Combines xs back together"
    (is (= ["Once upon" "a time"]
           (lines-to-text [["Once" "upon"] ["a time"]])))))

(deftest simple-wrap
  (testing "Simple greedy wrap"
    (is (= "apple\nsauce" (wrap 10 "apple sauce")))
    (is (= "apple\nsauce" (wrap 9 "apple sauce")))
    (is (= "apple sauce" (wrap 11 "apple sauce")))
    (is (= "apple sauce" (wrap 12 "apple sauce")))))

(defn slurp-test-file
  "Reads in a file for testing"
  [dir filename]
  (trim-newline (slurp (str dir filename))))

(def test-file-names
  (filter #(.endsWith % ".txt")
          (map #(.getName %) (file-seq (io/file input-dir)))))

(defn test-file
  "Tests a file, assuming there is data in test/inputs and test/outputs"
  [filename]
  (let [input (slurp-test-file input-dir filename)
        output (slurp-test-file greedy-dir filename)]
    (is (= output (wrap 40 input)))))

(deftest file-tests
  (testing "test " test-file-names
           (doseq [x test-file-names] (test-file x))))
