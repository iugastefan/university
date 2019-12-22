import Data.Char
data Linie = L [ Int ] 
     deriving (Eq)
data Matrice = M [ Linie ]
     deriving (Eq)


lungime :: Linie -> Int
lungime (L xs) = length xs

liniiN :: Matrice -> Int -> [ Linie ]
liniiN (M xs) n
    | n < 0 = error("N negativ")
    | otherwise = [x|x<-xs, (lungime x) == n]
--    | otherwise = filter(\x -> (lungime x) == n) xs


testLinii :: Bool
testLinii = liniiN (M [ L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3] ]) 3 == [ L[1,2,3], L[8,5,3] ]
 
pozElem :: Linie -> Bool
pozElem (L xs) = and (map (\x -> x>0) xs)

pozElemN :: [Linie] -> Bool
pozElemN xs = and (map pozElem xs)

doarPozN :: Matrice -> Int -> Bool
doarPozN n = pozElemN.(liniiN n)

testDoarPozn1 :: Bool
testDoarPozn1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == True

testDoarPozn2 :: Bool
testDoarPozn2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == False

sumaLinie :: Linie -> Int
sumaLinie (L xs) = foldr (+) 0 xs

verifica :: Matrice -> Int -> Bool
verifica (M xs) n = and (map (\x -> sumaLinie x == n) xs)

testVerifica1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10 == False
testVerifica2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25 == True

instance Show Linie where

    --show (L []) = ""
    --show (L (x:xs)) = (intToDigit x) : " " ++ (show (L xs))

    --show (L xs) = foldl (++) "" (map (\x->(show x)++" ") xs)

    show (L xs) = concatMap (\ x -> (show x) ++ " ") xs

instance Show Matrice where

    --show (M []) = ""
    --show (M (x:xs)) = (show x) ++ "\n" ++ (show (M xs))

    --show (M xs) = foldl (++) "" (map (\x->(show x)++"\n") xs)

    show (M xs) = concatMap (\ x -> (show x) ++ "\n") xs

l1 :: Linie
l1 = L [1,2,3]
l2 :: Linie
l2 = L [4,5]
l3 :: Linie
l3 = L [2,3,6,8]
l4 :: Linie
l4 = L [8,5,3]
m1 :: Matrice
m1 = M [l1, l2, l3, l4]
