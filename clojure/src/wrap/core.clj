(ns wrap.core
  (require [wrap.greedy :as greedy]
           [wrap.minimum_raggedness :as smart])
  (:gen-class))

(defn -main
  "Wrap the input file"
  [& args]
  (print (smart/wrap (slurp (first args)))))
