-- copies a file
-- from chapter 7 of AGITH, "IO"

import System.IO
import Control.Exception

main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  fromHandle <- getAndOpenFile "Copy from: " ReadMode
  toHandle <- getAndOpenFile "Copy to: " WriteMode
  contents <- hGetContents fromHandle
  hPutStr toHandle contents
  hClose toHandle
  putStr "Done.\n"

getAndOpenFile :: String -> IOMode -> IO Handle
getAndOpenFile prompt mode = do
  putStr prompt
  name <- getLine
  catch (openFile name mode)
    ((\_ -> do putStrLn ("Cannot open " ++ name ++ "\n")
               getAndOpenFile prompt mode)
     :: IOError -> IO Handle)
