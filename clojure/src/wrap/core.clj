(ns wrap.core
  (require [wrap.greedy :as greedy])
  (:gen-class))

(defn -main
  "Wrap the input file"
  [& args]
  (print (greedy/wrap (slurp (first args)))))
