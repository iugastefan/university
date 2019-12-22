
--- Monada Writer

newtype WriterS a = Writer { runWriter :: (a, String) } 


instance  Monad WriterS where
  return va = Writer (va, "")
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance  Applicative WriterS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance  Functor WriterS where              
  fmap f ma = pure f <*> ma     

tell :: String -> WriterS () 
tell log = Writer ((), log)
  
logIncrement :: Int  -> WriterS Int
logIncrement x = do
                 tell ( "increment: " ++ show x ++ "\n")
                 return ( x + 1 )

logIncrementN :: Int -> Int -> WriterS Int
logIncrementN x n = do
                    if n>1
                    then 
                        do
                        y <- logIncrement x
                        logIncrementN y (n-1)
                    else
                        logIncrement x
   
                  
isPos :: Int -> WriterS Bool
isPos x = if (x>= 0) then (Writer (True, "poz")) else (Writer (False, "neg"))
mapWriterS :: (a -> WriterS b) -> [a] -> WriterS [b]
mapWriterS f xs = let (x,y) =  unzip $ map runWriter $ map f xs in Writer (x,(concat y))
