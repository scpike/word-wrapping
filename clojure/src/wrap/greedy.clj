(ns wrap.greedy)
(use '[clojure.string :only (split join)])

(def default-width 20)

(defn words [text]
  "Splits an input text into an array of words"
  (clojure.string/split text #"\s+"))

; Take from words while length of the current line is <
; default-width. Once we get to the end of the line start a new
; vector.
(defn lines [ary cutoff]
  (let [[acc v]
        (reduce (fn [[acc v s] x]
                  (let [new-c (+ s (count x))]
                    (if (<= new-c cutoff)
                      [acc (conj v x) new-c]
                      [(conj acc v) [x] (count x)])))
                [[] [] 0] ary)]
    (conj acc v)))

; Converts an array of arrays of words to an array of strings
(defn lines-to-text [ary]
  (map #(join " " %) ary))

(defn wrap [text]
  (join "\n" (lines-to-text (lines (words text) default-width))))
