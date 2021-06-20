-- from Chapter 3 of A Gentle Introduction to Haskell: Functions
-- can use this by doing :load functions.hs in the REPL

-- regular curried function
add :: Integer -> Integer -> Integer
add x y = x + y

-- uncurried function: application by a tuple
mul (x, y) = x * y

-- function application has higher precedence than infix operators

-- lambda abstractions
addlambda = \x y -> x + y

inc = add 1

-- function composition (an infix operator)
addtwo = inc . inc

-- infix operators and partially-applied infix operators require parentheses
arr1 = map (^2) [1,2,3,4,5]
arr2 = map (2^) [1,2,3,4,5]

-- can specify the associativity and precedence of infix expressions
-- very similar to what we did in bison when parsing expressions
-- infixr 5 ++
-- infixr 9 .

-- bottom (_|_) is actually implemented as undefined in Haskell
const1 = const 1
testlazy = const1 undefined

-- "infinite" data structures
ones = 1 : ones
numsFrom n = n : numsFrom (n+1)
squares = map (^2) (numsFrom 0)
takeFromInfinite = take 5 squares

fib = 0 : 1 : [a+b | (a,b) <- zip fib (tail fib)]

-- error function
-- error "Hello, world error"
