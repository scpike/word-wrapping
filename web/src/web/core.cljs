(ns web.core
  (:require [clojure.browser.dom  :as dom]
            [clojure.browser.event :as event]
            [wrap.minimum_raggedness :as smarter]
            [wrap.greedy :as greedy]))

; (dom/log util/default-width)
(def input (dom/get-element "input"))
(def width (dom/get-element "width"))
(def dest (dom/get-element "output"))

(defn wrap-with [f]
  (fn [e]
    (let [text (.-value input)
          width (js/parseInt (.-value width))]
      (set! (.-innerHTML dest) (f width text)))))

(event/listen
 (dom/get-element "wrap-greedy") :click
 (wrap-with greedy/wrap-text))
(event/listen
 (dom/get-element "wrap-smart") :click
 (wrap-with smarter/wrap-text))

(dom/log "compiled3")
