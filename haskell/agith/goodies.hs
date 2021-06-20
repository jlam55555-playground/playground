-- this comes from "A Gentle Introduction to Haskell"
-- 
-- compile with ghc --dynamic goodies.ghc && ./goodies
-- won't print anything because I don't know how to print things yet
-- can run this in ghci as well
--
-- I have no idea how the indentation is supposed to work in haskell-mode

main :: IO ()
main = return ()

quicksort [] = []
quicksort (x:xs) = quicksort [y | y <- xs, y < x ]
                   ++ [x]
                   ++ quicksort [y | y <- xs, y >= x]

type String = [Char]
-- "hello" ++ " world"
