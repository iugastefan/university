import Test.QuickCheck

data Expr = Const Int -- integer constant
          | Expr :+: Expr -- addition
          | Expr :*: Expr -- multiplication
           deriving Eq
data Operation = Add | Mult deriving (Eq, Show)
data Tree = Lf Int -- leaf
          | Node Operation Tree Tree -- branch
           deriving (Eq, Show)
instance Show Expr where
    show (Const x) = show x
    show (x :+: y) = "(" ++ (show x) ++ " + " ++ (show y) ++ ")"
    show (x :*: y) = "(" ++ (show x) ++ " * " ++ (show y) ++ ")"

evalExp :: Expr -> Int
evalExp (Const x) = x
evalExp (x :+: y) = (evalExp x) + (evalExp y)
evalExp (x :*: y) = (evalExp x) * (evalExp y)

exp1 = ((Const 2 :*: Const 3) :+: (Const 0 :*: Const 5))
exp2 = (Const 2 :*: (Const 3 :+: Const 4))
exp3 = (Const 4 :+: (Const 3 :*: Const 3))
exp4 = (((Const 1 :*: Const 2) :*: (Const 3 :+: Const 1)) :*: Const 2)

test11 = evalExp exp1 == 6
test12 = evalExp exp2 == 14
test13 = evalExp exp3 == 13
test14 = evalExp exp4 == 16

evalArb :: Tree -> Int
evalArb (Lf x) = x
evalArb (Node Add x y) = (evalArb x) + (evalArb y)
evalArb (Node Mult x y) = (evalArb x) * (evalArb y)

expToArb :: Expr -> Tree
expToArb (Const x) = Lf x
expToArb (x :+: y) = Node Add (expToArb x) (expToArb y)
expToArb (x :*: y) = Node Mult (expToArb x) (expToArb y)

arb1 = Node Add (Node Mult (Lf 2) (Lf 3)) (Node Mult (Lf 0)(Lf 5))
arb2 = Node Mult (Lf 2) (Node Add (Lf 3)(Lf 4))
arb3 = Node Add (Lf 4) (Node Mult (Lf 3)(Lf 3))
arb4 = Node Mult (Node Mult (Node Mult (Lf 1) (Lf 2)) (Node Add (Lf 3)(Lf 1))) (Lf 2)

test21 = evalArb arb1 == 6
test22 = evalArb arb2 == 14
test23 = evalArb arb3 == 13
test24 = evalArb arb4 == 16

class MySmallCheck a where
     smallValues :: [a]
     smallCheck :: ( a -> Bool ) -> Bool
     smallCheck prop = and [ prop x | x <- smallValues ]

checkExp :: Expr -> Bool
checkExp x = (evalExp x) == (evalArb (expToArb x))

instance MySmallCheck Expr where
    smallValues = [exp1, exp2, exp3, exp4]

double :: Int -> Int
double = (*2)
triple :: Int -> Int
triple = (*3)
penta :: Int -> Int
penta = (*5)
test :: Int -> Bool
test x = (double x + triple x) == (penta x)
testErr = False

myLookUp :: Int -> [(Int,String)]-> Maybe String
myLookUp nr xs
    | null xs = Nothing
    | nr == fst (head xs) = Just (snd (head xs))
    | otherwise = myLookUp nr (tail xs)

myLookUp2 :: Int -> [(Int,String)]-> Maybe String
myLookUp2 nr xs = let x = filter (\(x,_)-> x==nr) xs 
                  in if null x 
                     then Nothing 
                     else Just (snd (x!!0))

testLookUp :: Int -> [(Int,String)] -> Bool
testLookUp nr xs = (myLookUp2 nr xs) == (lookup nr xs)

testLookUpCond :: Int -> [(Int,String)] -> Property
testLookUpCond n list = n > 0 && n `div` 5 == 0 ==> testLookUp n list

data ElemIS = I Int | S String
     deriving (Show,Eq)

instance Arbitrary ElemIS where
    arbitrary = do 
                x <- arbitrary 
                y <- arbitrary 
                elements [I x, S y]

myLookUpElem :: Int -> [(Int,ElemIS)]-> Maybe ElemIS
myLookUpElem nr xs = let x = filter (\(x,_)-> x==nr) xs in if null x then Nothing else Just (snd (x!!0))

testLookUpElem :: Int -> [(Int,ElemIS)] -> Bool
testLookUpElem nr xs = (myLookUpElem nr xs) == (lookup nr xs)

myreverse :: [a] -> [a]
myreverse [] = []
myreverse (x:xs) = (myreverse xs) ++ [x]

wrong :: [ElemIS] -> Bool
wrong xs = xs == myreverse xs
