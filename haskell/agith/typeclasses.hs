x `elem` []     = False
x `elem` (y:ys) = x Main.== y || (x `Main.elem` ys)

class Eq a where
  (==), (/=) :: a -> a -> Bool
  x /= y = not (x Main.== y)

instance Main.Eq Integer where
  x == y = x Prelude.== y

instance Main.Eq Double where
  x == y = x Prelude.== y

data Tree a = Leaf a
            | Branch (Tree a) (Tree a)

instance (Main.Eq a) => Main.Eq (Tree a) where
  Leaf a == Leaf b                 = a Main.== b
  (Branch l1 r1) == (Branch l2 r2) = (l1 Main.== l2) && (r1 Main.== r2)
  _ == _                           = False

class (Main.Eq a) => Ord a where
  (<), (<=), (>=), (>) :: a -> a -> Bool
  max, min :: a -> a -> a

-- example: definition of quicksort from earlier
-- quicksort :: (Main.Ord a) => [a] -> [a]

-- testing multiple inheritance
-- they both seem to be in the global namespace, not allowed
class ParentA t where
  foo :: t -> String

-- class ParentB t where
--   foo :: t -> Integer

data Child = Chld

instance ParentA Child where
  foo _ = "Hello, world!"

-- instance ParentB Child where
--   foo _ = 42

-- type applications written like function applications
testMap :: (a -> b) -> [a] -> [b]
testMap _ []     = []
testMap f (x:xs) = f x : testMap f xs

-- this is thes same as:
testMap2 :: ((->) ((->) a b) ((->) ([] a) ([] b)))
testMap2 _ []     = []
testMap2 f (x:xs) = f x : testMap f xs
