-- based on AGITH Chapter 7: Input/Output
-- getChar :: IO Char
-- putChar :: Char -> IO ()

import System.IO
import System.IO.Error
import Control.Exception

main :: IO [()]
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  do c <- getChar
     putChar c
     do d <- ready
        if d
          then do putChar 't'
          else do putChar 'f'
     do l <- Prelude.getLine
        Main.putStr l
     Main.sequence_ todoList
     sequence todoList
                        
ready :: IO Bool
ready = do c <- getChar
           return (c == 'y')

getLine :: IO String
getLine = do c <- getChar'
             if c == '\n'
               then return ""
               else do l <- Main.getLine
                       return (c:l)

todoList :: [IO ()]
todoList = [
  putChar 'a',
  do putChar 'b'
     putChar 'c',
  do c <- getChar
     putChar c
  ]

sequence_ :: [IO ()] -> IO ()
-- sequence_ [] = return ()
-- sequence_ (a:as) = do a
--                       Main.sequence_ as

sequence_ = foldr (>>) (return ())

putStr :: String -> IO ()
putStr s = Main.sequence_ (map putChar s)

-- sequence is a little difference from sequence_: sequence
-- has type Monad m => [m n] -> m [n], so it aggregates the
-- results into a list

-- exception vs. error: error is fatal, exception can be
-- caught and handled inside of the monad

getChar' :: IO Char
getChar' = catch getChar eofHandler where
  eofHandler e = if isEOFError e then return '\n' else ioError e

getLine' :: IO String
getLine' = catch getLine'' (\err -> return ("Error: " ++ show (err :: IOError)))
  where
    getLine'' = do c <- getChar'
                   if c == '\n'
                     then return ""
                     else do l <- getLine'
                             return (c:l)

-- type FilePath = String -- path names in the filesystem
-- openFile :: FilePath -> IOMode -> IO Handle
-- hClose :: Handle -> IO ()
-- data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode

-- the hGetChar function is more fundamental than getChar
-- getChar = hGetChar stdin

-- reads everything from stdin (lazily)
-- getContents :: IO String
