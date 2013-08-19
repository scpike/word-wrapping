(ns wrap.util
  (:use [clojure.string :only (split join)]))

(defn words
  "Splits an input text into an array of words"
  [text]
  (split text #"\s+"))

(defn lines-to-text
  "Convert this 2d array (array of array of words) into an array of strings"
  [xs]
  (map #(join " " %) xs))
