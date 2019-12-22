
-- la nevoie decomentati liniile urmatoare:

import Data.Char
import Data.List


---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2     = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

{-| @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
recursie. Completați definiția funcției fibonacciPereche.

Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
-}
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = let x = fibonacciPereche(n-1) in (snd x, (fst x+ snd x))


---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l    = l
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h:t)
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where t' = semiPareRecEq t

---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]


-- L2.2
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec lo hi xs
   | null xs = xs
   | lo<= (head xs) && (head xs)<=hi = (head xs) : inIntervalRec lo hi (tail xs)
   | otherwise = inIntervalRec lo hi (tail xs)

inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp lo hi xs = [x|x<-xs, lo<=x && x<=hi]

-- L2.3

pozitiveRec :: [Int] -> Int
pozitiveRec l
   | null l = 0
   | (head l) > 0 = 1+pozitiveRec (tail l)
   | otherwise = pozitiveRec (tail l)


pozitiveComp :: [Int] -> Int
pozitiveComp l = length [x|x<-l, x>0]

-- L2.4 
pozitiiImpareRecH :: [Int] -> Int -> [Int]
pozitiiImpareRecH l poz
   | null l = l
   | (mod (head l) 2)==1 = poz:pozitiiImpareRecH (tail l) (poz+1)
   | otherwise = pozitiiImpareRecH (tail l) (poz +1)
pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec l = pozitiiImpareRecH l 0


pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [poz|(x,poz)<-(zip l [0..]), mod x 2 == 1]


-- L2.5

multDigitsRec :: String -> Int
multDigitsRec sir
   | null sir = 1
   | isDigit (head sir) = digitToInt (head sir) * multDigitsRec(tail sir)
   | otherwise = multDigitsRec(tail sir)

multDigitsComp :: String -> Int
multDigitsComp sir = product [digitToInt x|x<-sir, isDigit x]

-- L2.6 

discountRec :: [Float] -> [Float]
discountRec list
   | null list = list
   | x<200 = x:discountRec (tail list) 
   | otherwise = discountRec (tail list)
   where x = (head list)*0.75

discountComp :: [Float] -> [Float]
discountComp list = [x*0.75|x<-list, x*0.75 < 200]


