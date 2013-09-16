(defproject web "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :dependencies [[org.clojure/clojure "1.5.1"]]
  :plugins [[lein-cljsbuild "0.3.2"]]
  :cljsbuild {
              :crossovers [wrap]
              :crossover-path "crossover-cljs"
              :builds [{:source-paths ["src/web"]
                        :compiler {:output-to "js/main.js"
                                   :optimizations :whitespace
                                   :pretty-print true}}]}
  :main web.core)
