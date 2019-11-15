import Data.List (nub)
import Data.Maybe (fromJust)

data Fruct
    = Mar String Bool
    | Portocala String Int
      deriving(Show)


ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False, Portocala "Sanguinello" 10, Portocala "Valencia" 22, Mar "Golden Delicious" True, Portocala "Sanguinello" 15, Portocala "Moro" 12, Portocala "Tarocco" 3, Portocala "Moro" 12, Portocala "Valencia" 2, Mar "Golden Delicious" False, Mar "Golden" False, Mar "Golden" True]


ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala "Tarocco" _) = True
ePortocalaDeSicilia (Portocala "Moro" _) = True
ePortocalaDeSicilia (Portocala "Sanguinello" _) = True
ePortocalaDeSicilia _ = False


test_ePortocalaDeSicilia1 = ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 = ePortocalaDeSicilia (Mar "Ionatan" True) == False

nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia = sum . (map (\(Portocala _ y) -> y)) . (filter ePortocalaDeSicilia)

test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

nrMereViermi :: [Fruct] -> Int
nrMereViermi xs = (length.(filter (\x->x))) [x|(Mar _ x)<-xs]

test_nrMereViermi = nrMereViermi listaFructe == 2

type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa

vorbeste :: Animal -> String
vorbeste (Pisica _) = "Meow!"
vorbeste (Caine _ _)= "Woof!"

rasa :: Animal -> Maybe String
rasa (Caine _ r) =Just r
rasa (Pisica _) = Nothing

type Nume = String
data Prop
    = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:
infixr 1 :->:
infixr 1 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not(Var "P") :&:Not(Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: ((Not(Var "P"):|:(Not(Var "Q"))):&:((Not(Var "P")):|:(Not(Var "R"))))

instance Show Prop where
    show (Var x) = x
    show F = "F"
    show T = "T"
    show (Not T) = "F"
    show (Not F) = "T"
    show (Not (Var x)) = "~"++x
    show (Not x) = "~("++(show x)++")"
    show ((x:|:y):&:z) = "("++(show x)++"|"++(show y)++")&"++(show z)
    show (x:&:(y:|:z)) = (show x)++"&("++(show y)++"|"++(show z)++")"
    show (x:|:y) = (show x)++"|"++(show y)
    show (x:&:y) = (show x)++"&"++(show y)
    show (x:->:y) = (show x)++"->"++(show y)
    show (x:<->:y) = (show x)++"<->"++(show y)

test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var x) env = impureLookup x env
eval (x:&:y) env = (eval x env)&&(eval y env)
eval (x:|:y) env = (eval x env)||(eval y env)
eval (Not x) env = not(eval x env)
eval (x:->:y) env = if (eval x env) == False then True else if (eval y env) == True then True else False
eval (x:<->:y) env = (eval (x:->:y) env)&&(eval (y:->:x) env)

test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True


variabile :: Prop -> [Nume]
variabile (Var x) = [x]
variabile (x:|:y) = nub((variabile x) ++ (variabile y))
variabile (x:&:y) = nub((variabile x) ++ (variabile y))
variabile (x:->:y) = nub((variabile x) ++ (variabile y))
variabile (x:<->:y) = nub((variabile x) ++ (variabile y))
variabile (Not x) = variabile x

test_variabile = variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

envsHelp :: Nume -> [(Nume,Bool)]
envsHelp x = [(x,False),(x,True)]
envs :: [Nume] -> [Env]
envs xs = sequence(map (\x->envsHelp x) xs)

test_envs =
      envs ["P", "Q"]
      ==
      [ [ ("P",False)
        , ("Q",False)
        ]
      , [ ("P",False)
        , ("Q",True)
        ]
      , [ ("P",True)
        , ("Q",False)
        ]
      , [ ("P",True)
        , ("Q",True)
        ]
      ]

satisfiabila :: Prop -> Bool
satisfiabila x =  or (map (\y->eval x y) (envs(variabile x)))

test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida x =  and (map (\y->eval x y) (envs(variabile x)))

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True

val :: Env -> [Bool]
val = map(\(y,z)->z)

helper :: Prop -> ([Nume], Prop, [([Bool], Bool)])
helper x = (variabile x,x,[(val y,eval x y)| y<- (envs(variabile x))])

printVars [] = do putStr "| "
printVars (var:vars) = 
    do
    putStr $ var++" "
    printVars vars

printLiniiProp [] = do putStrLn ""
printLiniiProp prop = 
    do 
    putStr "-"
    printLiniiProp (tail prop)

printLiniiVars [] = 
    do
    putStr "| "
printLiniiVars (var:vars) = 
    do
    putStr $ "- "
    printLiniiVars vars

printTrueVars [] =
    do putStr "| "
printTrueVars bools = 
    do
    if (head bools) == True then putStr "T " else putStr "F "
    printTrueVars (tail bools)
printTrue (bools, bool) =
    do
    printTrueVars bools
    if bool == True then putStrLn "T" else putStrLn "F"
printTrues [] =
    do
    putStrLn ""
printTrues xs =
    do
    printTrue (head xs)
    printTrues (tail xs)

tabelaAdevar :: Prop -> IO ()
tabelaAdevar prop = 
    do
    let (vars,x,trues) = helper prop
    printVars vars
    putStrLn $ show x
    printLiniiVars vars 
    printLiniiProp $ show x
    printTrues trues
   

getTrues :: Prop -> [Bool]
getTrues x = [(eval x y)| y <- (envs(variabile x))]

echivalenta :: Prop -> Prop -> Bool
echivalenta x y = and (getTrues (x:<->:y))
test_echivalenta1 = True == (Var "P" :&: Var "Q") `echivalenta` (Not (Not (Var "P") :|: Not (Var "Q")))
test_echivalenta2 = False == (Var "P") `echivalenta` (Var "Q")
test_echivalenta3 = True == (Var "R" :|: Not (Var "R")) `echivalenta` (Var "Q" :|: Not (Var "Q"))
