(ns wrap.greedy)
(use '[clojure.string :only (split join)])

(def default-width 10)

(defn words
  "Splits an input text into an array of words"
  [text]
  (clojure.string/split text #"\s+"))

(defn lines-to-text
  "Convert this 2d array (array of array of words) into an array of strings"
  [xs]
  (map #(join " " %) xs))

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

(split-lines 10 ["apple" "sauce" "for" "a" "partie" "a"])

(defn wrap
  ([text]  (join "\n" (lines-to-text (split-lines default-width (words text)))))
  ([width text]  (join "\n" (lines-to-text (split-lines width (words text))))))
