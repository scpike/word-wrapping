(ns wrap.minimum_raggedness_test
  (:use clojure.test
        wrap.minimum_raggedness
        [clojure.string :only (trim-newline)]
        [clojure.java.io :as io]))

(def input-dir "../test/input/")
(def greedy-dir "../test/minimum-raggedness/")

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

;(deftest file-tests
;  (testing "test " test-file-names
;           (doseq [x test-file-names] (test-file x))))
