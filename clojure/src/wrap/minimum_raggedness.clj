(ns wrap.minimum_raggedness
  (:use [clojure.string :only (join)])
  (:require [wrap.util :as util]))

(def infinity 100000)

(defn sum-len-between [xs i j]
  "Sum the lengths of the words in xs between index i and j"
  (let [xs (map count (subvec xs i (+ 1 j)))]
    (reduce + xs)))

(defn calc-cost-between
  "Calculate the cost of a line starting at words[i] and ending at
   words[j]. Cost is defined as the square of the whitespace at the
   end of the line. 0 cost for the last line."
  [cutoff i j words]
  (let [cost (- cutoff ; line width
               (- j i) ; spaces
               (sum-len-between words i j))] ; word width
    (if (>= cost 0)
      (if (= (inc j) (count words)) 0 (* cost cost))
      infinity)))
(def cost-between (memoize calc-cost-between))

(declare optimal-cost)
(defn split-cost [cutoff end words split]
  (let [o (optimal-cost cutoff split words)
         c (cost-between cutoff (inc split) end words)]
    [(+ c (first o)) (last o) split]))

(defn best-split [cutoff end words splits]
  (first (sort (map #(split-cost cutoff end words %) splits))))

(defn calc-optimal-cost [cutoff j words]
  (let [cost (cost-between cutoff 0 j words)]
    (if (and (= cost infinity) (> j 0))
      (let [r (best-split cutoff j words (range 0 j))]
           [(first r) (conj (second r) (last r))])
      [cost []])))
(def optimal-cost (memoize calc-optimal-cost))

(defn reconstruct [splits xs]
  (map (fn [x] (subvec xs (first x) (last x)))
       (partition 2 1 (concat [0] (map inc splits) [(count xs)]))))

(defn split-lines [cutoff xs]
  "Split the input based on minimum ragednesss algorithm"
  (let* [ans (optimal-cost cutoff (dec (count xs)) xs)
         splits (last ans)
         cost (first ans)]
        (reconstruct splits xs)))

(defn wrap-text
  ([text] (util/wrap-with split-lines text))
  ([width text] (util/wrap-with split-lines width text)))
