-- AGITH Chapter 8: Standard Haskell Classes
-- Much of the code here will be commented out because it's already
-- defined in the Prelude

-- data Ordering = EQ | LT | GT
-- compare :: Ord a => a -> a -> Ordering

-- an infinite sequence [1,3..]
-- enumFromThen 1 3

data Color = Red | Orange | Yellow | Green | Blue | Violet deriving (Enum, Show)
[Red .. Yellow]

-- enums are mapped onto arithmetic sequences, i.e., equally spaced

-- read/show classes
-- show :: (Show a) => a -> String

showTree :: (Show a) => Tree a -> String
showTree (Leaf x) = show x
showTree (Branch l r) = "<" ++ showTree l ++ "|" ++ showTree r ++ ">"

-- a more efficient function than show
shows :: (Show a) => a -> String -> String
-- this basically builds the string in rtl, because of the non-associativity
-- of the cons operator

-- we can express show in terms of the shows operator
show x = shows x ""

-- for the Tree datatype:
showsTree :: (Show a) => Tree a -> String -> String
showsTree (Leaf x) s = shows x s
showsTree (Branch l r) s = '<' : showsTree l ('|' : showsTree r ('>' : s))

showTree :: (Show a) => Tree a -> String
showTree a = showsTree a ""

-- we can improve how this looks visually by using functional composition
-- this allows us to remove parenthesis (that build up in Lisp) and also allow
-- us to avoid carrying around the accumulator (by using currying);
-- note that (showsTree a) is a function, i.e., showsTree takes a Tree and
-- returns a "showing function", which allows us to compose it in this way
type ShowS = String -> String
showsTree :: (Show a) => Tree a -> ShowS
showsTree (Leaf x) = shows x
showsTree (Branch l r) = ('<':) . showsTree l . ('|':) . showsTree r . ('>':)

-- now we tackle the problem of parsing a string into a more complex object
-- the following type synonym is a function that takes a string as input and
-- return a list of (a, String) pairs. On a normal successful parse, a singleton
-- list is returned. If no results are found, an empty list is returned. If
-- there is an ambiguity during parsing, then multiple results are returned.
type ReadS a = String -> [(a, String)]

-- standard function for reading any Read instance
reads :: (Read a) => ReadS a

-- parsing function for binary trees produced by showsTree
readsTree :: (Read a) => ReadS (Tree a)
readsTree ('<':s) = [(Branch l r, u) |
                     (l, '|':t) <- readsTree s,
                     (r, '>':u) <- readsTree t]
readsTree s = [(Leaf x, t) | (x, t) <- reads s]

type ReadSRes a = [(a, String)]
a = Branch (Leaf 2) (Branch (Leaf 4) (Leaf 8))
b = showsTree a ""
c = readsTree b :: ReadSRes (Tree Integer)

-- defining Show and Read instances for Tree
instance Show a => Show (Tree a) where
  showsPrec _ x = showsTree x

instance Read a => Read (Tree a) where
  readsPrec _ s = readsTree s

left :: Tree a -> Tree a
left (Branch a b) = a

show a
read (show a) :: Tree Integer
left (read (show a) :: Tree Integer)

-- note that this is the first time I've noticed that the type annotations are
-- useful; without the type annotation the inferred type would be:
-- identity :: (Read a, Show b) => b -> a, and then we would have to annotate
-- the type of the output
identity :: (Read a, Show a) => a -> a
identity = read . show

identity a

-- derived instances
-- the following instances can be automatically derived
data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving Show

instance (Eq a) => Eq (Tree a) where
  (Leaf x) == (Leaf y) = x == y
  (Branch l r) == (Branch l' r') = l == l' && r == r'
  _ == _ = False

instance (Ord a) => Ord (Tree a) where
  (Leaf _) <= (Branch ) = True
  (Leaf x) <= (Leaf y) = x <= y
  (Branch _) <= (Leaf _) = False
  (Branch l r) <= (Branch l' r') = l <= l' || l == l' && r <= r'

-- these are equivalent to
data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving (Eq, Ord, Show)

-- lists (e.g., strings) can be thought of as deriving Eq, Ord automatically
