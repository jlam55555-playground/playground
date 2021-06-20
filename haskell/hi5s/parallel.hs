-- to be able to run this, we require the parallel library from cabal
-- cabal install --lib parallel
-- ghc -O2 --make parallel.hs -threaded -rtsopts
-- time ./parallel +RTS -N2

import Control.Parallel

-- easily allow for parallel computation
main = a `par` b `par` c `pseq` print (a + b + c)
  where
    a = ack 3 10
    b = fac 42
    c = fib 34

-- factorial function
fac 0 = 1
fac n = n * fac (n-1)

-- ackermann function
ack 0 n = n+1
ack m 0 = ack (m-1) 1
ack m n = ack (m-1) (ack m (n-1))

-- fibonacci function
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
