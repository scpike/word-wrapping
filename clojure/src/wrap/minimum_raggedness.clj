(ns wrap.minimum_raggedness
  (:use [clojure.string :only (join)]
         wrap.util))

(def default-width 40)
(def infinity Double/POSITIVE_INFINITY)

(defn sum-len-between [xs i j]
  "Sum the lengths of the words in xs between index i and j"
  (let [xs (map count (subvec xs i (+ 1 j)))]
    (reduce + xs)))

(defn cost-between [cutoff i j words]
  (let [cost (- cutoff ; line width
                (- j i) ; spaces
                (sum-len-between words i j))] ; word width
    (if (>= cost 0) (* cost cost) infinity)))
(def memoized-cost-between (memoize cost-between))

(def memoize-box (atom {}))

(defn optimal-cost [cutoff j words]
  (let [cost (memoized-cost-between cutoff 0 j words)
        splits []]
    (if-let [e (find @memoize-box [cutoff j words])]
       (val e)
      (let [ret
            (if (and (= cost infinity) (> j 0))
              (let* [candidate-splits (range 0 j)
                                        ; return a vector of [cost, split chain, split]
                     winner (first (sort (map (fn [s]
                                                (let [o (optimal-cost cutoff s words)
                                                  c (memoized-cost-between cutoff (inc s) j words)]
                                                  [(+ c (first o)) (last o) s])) candidate-splits)))]
                    [(first winner) (conj (second winner) (last winner))])
              [cost splits])]
        (swap! memoize-box assoc [cutoff j words] ret)
        ret
        ))))

(defn reconstruct [splits xs]
  (map (fn [x] (subvec xs (first x) (last x)))
       (partition 2 1 (concat [0] (map inc splits) [(count xs)]))))

(defn split-lines [cutoff xs]
  "Split the input based on minimum ragednesss algorithm"
  (let* [ans (optimal-cost cutoff (dec (count xs)) xs)
         splits (last ans)
         cost (first ans)]
        (reconstruct splits xs)))

(defn wrap
  ([text]  (join "\n" (lines-to-text (split-lines default-width (words text)))))
  ([width text]  (join "\n" (lines-to-text (split-lines width (words text))))))
