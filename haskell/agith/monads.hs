-- from AGITH Chapter 9: About Monads

-- the monad is built on top of a polymorphic type, and is defined by
-- instance declarations of Functor, Monad, or MonadPlus classes

-- polymorphic types can be thought of as containers for values of another
-- type, and we can think of monads as containers

-- functors are governed by:
fmap id = id
fmap (f . g) = fmap f . fmap g

-- the monad class defines two basic operators: >>= (bind) and return
infixl 1 >>, >>=
class Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
  fail :: String -> m a

  m >> k = m >>= \_ -> k
