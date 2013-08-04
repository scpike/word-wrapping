(ns wrap.greedy)
(use '[clojure.string :only (split)])

(def default-width 80)

(defn words [text]
  "Splits an input text into an array of words"
  (clojure.string/split text #"\s+"))

; Take from words while length of the current line is <
; default-width. Once we get to the end of the line start a new
; vector.
;
; Results should be a 2d vector
(defn lines [ary cutoff]
  (let [[acc v]
        (reduce (fn [[acc v s] x]
                  (let [new-c (+ s (count x))]
                    (if (<= new-c cutoff)
                      [acc (conj v x) new-c]
                      [(conj acc v) [x] (count x)])))
                [[] [] 0] ary)]
    (conj acc v)))

(lines (words "Once upon a time there was a man") 10)

(defn sum-with-count [ary]
  (reduce (fn [acc i] [(+ (first acc) i)
                       (+ 1 (last acc))])
          [0 0] ary))

(sum-with-count (take 10 (iterate inc 1)))

(defn split-after-sum [ary sum]
  (let [[acc v]
        (reduce (fn [[acc v s] x]
                  (let [new-s (+ s x)]
                    (if (<= new-s sum)
                      [acc (conj v x) new-s]
                      [(conj acc v) [x] x])))
                [[] [] 0] ary)]
    (conj acc v)))


(split-after-sum [1 1 1 1 1 1 1 1 1] 2)

(defn wrap [text]
  (words text))
