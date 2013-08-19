(ns wrap.greedy
  (:use [clojure.string :only (join)]
        [wrap.util]))

(def default-width 10)

(defn split-lines [cutoff xs]
  "Split the words so that the sum of the lengths of each line is <= cutoff"
  (let [[acc v]
        (reduce (fn [[acc v s] x]
                  (let [new-c (+ s (count x))]
                    (if (<= new-c cutoff)
                      [acc (conj v x) (inc new-c)]
                      [(conj acc v) [x] (inc (count x))])))
                [[] [] 0] xs)]
    (conj acc v)))

(defn wrap
  ([text]  (join "\n" (lines-to-text (split-lines default-width (words text)))))
  ([width text]  (join "\n" (lines-to-text (split-lines width (words text))))))
