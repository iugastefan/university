import Numeric.Natural

produsRec :: [Integer] -> Integer
produsRec xs
    | null xs = 1
    | otherwise = (head xs) * produsRec (tail xs)


produsFold :: [Integer] -> Integer
produsFold xs = foldr (*) 1 xs


andRec :: [Bool] -> Bool
andRec xs
    | null xs = True
    | otherwise = (head xs) && andRec (tail xs)



andFold :: [Bool] -> Bool
andFold xs = foldr (&&) True xs

concatRec :: [[a]] -> [a]
concatRec xs
    | null xs = []
    | otherwise = (head xs) ++ concatRec (tail xs)



concatFold :: [[a]] -> [a]
concatFold xs = foldr (++) [] xs

rmChar :: Char -> String -> String
rmChar c xs = [y|y<-xs, y/=c] 



rmCharsRec :: String -> String -> String
rmCharsRec xs1 xs2
    | null xs1 || null xs2 = xs2
    | otherwise = rmCharsRec (tail xs1) (rmChar (head xs1) xs2)

test_rmchars :: Bool
test_rmchars = rmCharsRec ['a'..'l'] "fotbal" == "ot"



rmCharsFold :: String -> String -> String
rmCharsFold xs1 xs2 = foldr (rmChar) xs2 xs1



logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1))


logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079
ex1 :: Natural
ex1 = 22


ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3]

ex21 :: Fractional a => a
ex21 = head ex20

ex22 :: Fractional a => a
ex22 = ex20 !! 2

ex23 :: Fractional a => [a]
ex23 = drop 2 ex20

ex24 :: Fractional a => [a]
ex24 = tail ex20


ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2

ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7
ex33 :: Bool
ex33 = ex31 5

ex34 :: Bool
ex34 = ex31 7

ex35 :: Bool
ex35 = ex32 5

ex36 :: Bool
ex36 = ex32 7

findFirst :: (a -> Bool) -> [a] -> Maybe a
findFirst f [] = Nothing
findFirst f (x:xs) = if f x then Just x else (findFirst f xs)

findFirstNat :: (Natural -> Bool) -> Natural
findFirstNat p = n
  where Just n = findFirst p [0..]



ex4b :: Natural
ex4b = findFirstNat (\n -> n * n >= 12347)

inversa :: Ord a => (Natural -> a) -> (a -> Natural)
inversa f y = findFirstNat (\n -> f n >= y)
