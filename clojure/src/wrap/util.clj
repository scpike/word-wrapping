(ns wrap.util
  (:use [clojure.string :only (split join)]))

(def default-width 40)

(defn paragraphs
  "Splits an input text into an array of paragraphs"
  [text]
  (split text #"\n\n+"))

(defn words
  "Splits an input text into an array of words"
  [text]
  (split text #"\s+"))

(defn lines-to-text
  "Convert this 2d array (array of array of words) into an array of strings"
  [xs]
  (map #(join " " %) xs))

(defn wrap-paragraph
  "Wrap an individual paragraph using f."
  [f width par]
  (join "\n" (lines-to-text (f width (words par)))))

(defn wrap-paragraphs
  "Wrap all paragraphs in text with f. Return a re-combined string"
  [f width text]
  (join "\n\n" (map #(wrap-paragraph f width %) (paragraphs text))))

(defn wrap-with
  ([f text] (wrap-with f default-width text))
  ([f text width] (wrap-paragraphs f text width)))