import Data.Char
data Linie = L [ Int ] 
     deriving (Eq)
data Matrice = M [ Linie ]
     deriving (Eq)
testLinii = liniiN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3 == [L[1,2,3], L[8,5,3]]


lungime :: Linie -> Int
lungime (L xs) = length xs

liniiN :: Matrice -> Int -> [ Linie ]
liniiN (M xs) n = filter(\x -> (lungime x) == n) xs
--liniiN (M xs) n = [x|x<-xs, (lungime x) == n]

pozElem :: Linie -> Bool
pozElem (L xs) = and (map (\x -> x>0) xs)

pozElemN :: [Linie] -> Bool
pozElemN xs = and (map pozElem xs)

doarPozN n= pozElemN.(liniiN n)


testDoarPozn1 = doarPozN (M [L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3==True
testDoarPozn2 = doarPozN (M [L[1,2,-3], L[4,5], L[2,3,6,8], L[8,5,3]]) 3==False

sumaLinie :: Linie -> Int
sumaLinie (L xs) = foldr (+) 0 xs
verifica :: Matrice -> Int -> Bool
verifica (M xs) n = and (map (\x -> sumaLinie x == n) xs)
testVerifica1 = verifica (M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]) 10==False
testVerifica2 = verifica (M[L[2,20,3], L[4,21], L[2,3,6,8,6], L[8,5,3,9]]) 25==True

instance Show Linie where
    show (L []) = ""
    show (L xs) = (intToDigit(head xs)) : " "++(show (L (tail xs)))

instance Show Matrice where
    show (M []) = ""
    show (M xs) = (show (head xs))++"\n"++ (show (M (tail xs)))

-- M[L[1,2,3], L[4,5], L[2,3,6,8], L[8,5,3]]
-- 1 2 3
-- 4 5 
-- 2 3 6 8
-- 8 5 3
