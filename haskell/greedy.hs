import System.Environment
import qualified Data.Text.Lazy.IO as TIO
import qualified Data.Text.Lazy as TL

width = 100

wrapWords :: String -> String
wrapWords text =
  let (x:xs) = words text
  in fst $ foldl (\(acc, curLine) w -> (joinWord acc w curLine)) (x, x) $ xs
  where joinWord text word curLine
          | (length $ curLine ++ " " ++ word) <= width = (text ++ " " ++ word, curLine ++ " " ++ word)
          | otherwise = (text ++ "\n" ++ word, word)

main = do
  args <- getArgs
  text <- readFile $ head args
  putStrLn $ wrapWords $ text
