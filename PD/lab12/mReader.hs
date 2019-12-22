
---Monada Reader


newtype Reader env a = Reader { runReader :: env -> a }


instance Monad (Reader env) where
  return x = Reader (\_ -> x)
  ma >>= k = Reader f
    where f env = let a = runReader ma env
                  in  runReader (k a) env



instance Applicative (Reader env) where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)

instance Functor (Reader env) where
  fmap f ma = pure f <*> ma


ask :: Reader env env
ask = Reader id

local :: (r -> r) -> Reader r a -> Reader r a
local f ma = Reader $ (\r -> (runReader ma)(f r))

-- Reader Person String

data Person = Person { name :: String, age :: Int }

testPerson :: Person
testPerson = Person "nume" 20
showPersonN :: Person -> String
showPersonN (Person n _) = "NUME:" ++ (id n)

showPersonA :: Person -> String
showPersonA (Person _ n) = "AGE:" ++ (show n)


showPerson :: Person -> String
showPerson x = "("++(showPersonN x)++","++(showPersonA x)++")"

mshowPersonN ::  Reader Person String
mshowPersonN = do
               x<- ask
               return (showPersonN x)

mshowPersonA ::  Reader Person String
mshowPersonA = do
               x<- ask
               return (showPersonA x)

mshowPerson :: Reader Person String
mshowPerson = do
              x<- ask
              return (showPerson x)
