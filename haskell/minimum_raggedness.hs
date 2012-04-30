import System.Environment
width = 100
oneSpaceWidth = 1

costBetween :: [String] -> Int -> Int -> Int
costBetween words i j = width
                        - (j - i) * oneSpaceWidth
                        - (foldl (\acc w -> acc + length w) 0 wds)
  where wds = slice i j words
        slice from to xs = take (to - from + 1) (drop (from - 1) xs)
-- main = do
--   args <- getArgs
--   text <- readFile $ head args
--   putStrLn $ wrapWords $ text
