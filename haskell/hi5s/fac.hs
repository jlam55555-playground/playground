main = print (fac 42)

fac n = if n == 0 then 1 else n * fac (n - 1)

-- alternatively, using the pattern-matching syntax:
-- fac 0 = 1
-- fac n = n * fac (n - 1)
