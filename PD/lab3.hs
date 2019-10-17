import   Data.List

-- L3.1 Încercati sa gasiti valoarea expresiilor de mai jos si
-- verificati raspunsul gasit de voi în interpretor:
{-
[x^2 | x <- [1 .. 10], x `rem` 3 == 2]
[(x, y) | x <- [1 .. 5], y <- [x .. (x+2)]]
[(x, y) | x <- [1 .. 3], let k = x^2, y <- [1 .. k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A' .. 'Z']]
[[x .. y] | x <- [1 .. 5], y <- [1 .. 5], x < y ]

-}

factori :: Int -> [Int]
factori x = [y|y<-[1..x],x `rem` y == 0]

prim :: Int -> Bool
prim x =(length.factori) x == 2

numerePrime :: Int -> [Int]
numerePrime x = [y|y<-[2..x],prim y]

-- L3.2 Testati si sesizati diferenta:
-- [(x,y) | x <- [1..5], y <- [1..3]]
-- zip [1..5] [1..3]

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 l1 l2 l3 = [(x,y,z)|(x,(y,z))<- zip l1 (zip l2 l3)]


--------------------------------------------------------
----------FUNCTII DE NIVEL INALT -----------------------
--------------------------------------------------------
aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f.f
--aplica2 f = \x -> f (f x)
aplica2  = \f x -> f (f x)

-- L3.3
{-
map (\ x -> 2 * x) [1 .. 10]
map (1 `elem` ) [[2, 3], [1, 2]]
map ( `elem` [2, 3] ) [1, 3, 4, 5]
-}

-- firstEl [ ('a', 3), ('b', 2), ('c', 1)]
firstEl ::[(a, b)] -> [a]
firstEl x = map (fst) x


-- sumList [[1, 3],[2, 4, 5], [], [1, 3, 5, 6]]
sumList :: [[Int]] -> [Int]
sumList x  = map sum x


prelH :: Int -> Int
prelH x
   | x `rem` 2 == 0 = x `div` 2
   | otherwise  = x*2
-- prel2 [2,4,5,6]
prel2 :: [Int] -> [Int]
prel2 x = map prelH x

apartine :: Char -> [[Char]] -> [[Char]]
apartine c l = filter (c `elem`) l

patrate :: [Int] -> [Int]
patrate l = (map (^2).filter odd) l

patratepoz :: [Int] -> [Int]
patratepoz l= (map (\(_,y)->y^2).filter (\(x,_)->odd x).zip [1..]) l 

numaiVocale :: [[Char]] -> [[Char]]
numaiVocale l = map (filter (\x ->x `elem` "aeiouAEIOU")) l

mymap :: (a->b) -> [a] -> [b]
mymap f [] = []
mymap f x = f(head x):mymap f (tail x)

myfilter :: (a->Bool)->[a]->[a]
myfilter f x
    | null x = x
    | f (head x) = (head x):myfilter f (tail x)
    | otherwise = myfilter f(tail x)

numerePrimeCiur :: Int -> [Int]
numerePrimeCiur n = ciur [2..n]
ciur :: [Int]->[Int]
ciur x    
    | null x = x
    | otherwise = (head x): (ciur.filter (\y-> y `rem` (head x) /=0)) (tail x)

ordonataNat :: [Int] -> Bool
ordonataNat [] = True
ordonataNat [x] = True
ordonataNat (x:xs) = and [y<w | (y,w)<-zip (x:xs) xs]


ordonataNat1 :: [Int] -> Bool
ordonataNat1 [] = True
ordonataNat1 (x:xs)
    | null xs = True
    | otherwise = and [x<(head xs), ordonataNat1 xs]

ordonata :: [a] -> (a->a->Bool)->Bool
ordonata (x:xs) op = and [op y w | (y,w)<-zip (x:xs) xs]

maimic x y = x<y
diviz x y = mod x y == 0

-- Nu merge ordonare
-- ordonata [(1,5),(2,4)] (<) ar trebui sa fie False
(*<*) :: (Integer, Integer) -> (Integer,Integer) -> Bool
(*<*) (x1,y1) (x2,y2) = and [x1<x2,y1<y2] 

compuneList :: (b->c) -> [(a->b)] -> [(a->c)]
compuneList f xs = map (f.) xs

aplicaList :: a -> [(a->b)] -> [b]
aplicaList x f = [y x|y<-f]

myzip4 :: [a] -> [b] -> [c] -> [(a,b,c)]
myzip4 x y z = map (\(w1, (w2,w3))->(w1,w2,w3)) (zip x (zip y z))
