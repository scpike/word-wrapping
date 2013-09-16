(ns wrap.greedy
  (:use [clojure.string :only (join)])
  (:require [wrap.util :as util]))

(defn split-lines
  "Split the words so that the sum of the lengths of each line is <= cutoff"
  [cutoff xs]
  (let [[acc v]
        (reduce (fn [[acc v s] x]
                  (let [new-c (+ s (count x))]
                    (if (<= new-c cutoff)
                      [acc (conj v x) (inc new-c)]
                      [(conj acc v) [x] (inc (count x))])))
                [[] [] 0] xs)]
    (conj acc v)))

(defn wrap-text
  ([text] (util/wrap-with split-lines text))
  ([width text] (util/wrap-with split-lines width text)))
