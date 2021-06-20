-- function that duplicates the first element of a list: an as-pattern
f s@(x:xs) = x:s

head (x:_) = x
tail (_:xs) = xs

-- top-level patterns may have a boolean guard
sign x | x > 0 = 1
       | x == 0 = 0
       | x < 0 = -1

-- case statements
myTake m ys = case (m,ys) of
                (0,_)    -> []
                (_,[])   -> []
                (n,x:xs) -> x : myTake (n-1) xs

-- a client-server example
reqs = client Main.init resps
resps = server reqs

-- this won't work because client will fail on the first sequest because resps
-- will be []
-- client init (resp:resps) = init : client (next resp) resps
server (req:reqs) = process req : server reqs

client init ~(resp:resps) = init : client (next resp) resps

init = 0
next resp = resp
process req = req + 1

-- take 10 (zip reqs resps)

-- another example:
fib@(1:tfib) = 1 : 1 : [a+b | (a,b) <- zip fib fib]

-- using let
letTest = let a = 2
              b = 3
              c = 4
              d = 8
          in let y = a * b
                 f x = (x+y)/y
             in f c + f d

-- using where (like let for guards)
g x y | y>z = 1
      | y==z = 0
      | y<z = -1
  where z = x*x
