import Test.QuickCheck
{- Monada Maybe este definita in GHC.Base 

instance Monad Maybe where
  return = Just
  Just va  >>= k   = k va
  Nothing >>= _   = Nothing


instance Applicative Maybe where
  pure = return
  mf <*> ma = do
    f <- mf
    va <- ma
    return (f va)       

instance Functor Maybe where              
  fmap f ma = pure f <*> ma   
-}

(<=<) :: (a -> Maybe b) -> (c -> Maybe a) -> c -> Maybe b
f <=< g = (\ x -> g x >>= f)
ex1 = (\x -> Just (x*3)) <=< (\x -> Just (x+2))

asoc :: (Int -> Maybe Int) -> (Int -> Maybe Int) -> (Int -> Maybe Int) -> Int -> Bool
asoc f g h x = (h <=< (g <=< f) $ x) ==((h <=< g) <=< f $ x)
fc1 x = Just (x+4)
fc2 x = Just (x*2)
fc3 x = Just (x+3)
testasoc x = (asoc fc1 fc2 fc3 x)

pos :: Int -> Bool
pos  x = if (x>=0) then True else False

foo :: Maybe Int ->  Maybe Bool 
foo  mx =  mx  >>= (\x -> Just (pos x))  

foo9 :: Maybe Int ->  Maybe Bool 
foo9 mx = do
          x <- mx
          return (pos x)

addM :: Maybe Int -> Maybe Int -> Maybe Int  
addM mx my = mx >>= (\x -> my >>= (\y -> Just (x+y)))

addM2 :: Maybe Int -> Maybe Int -> Maybe Int  
addM2 mx my = do
              x<-mx
              y<-my
              return (x+y)
