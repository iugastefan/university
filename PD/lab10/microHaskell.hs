import Data.List
import Data.Maybe

type Name = String

data  Value  =  VBool Bool
        |VInt Int
        |VFun (Value -> Value)
        |VError
        
data  Hask  = HTrue | HFalse 
        |HIf Hask Hask Hask
        |HLit Int
        |Hask :==: Hask
        |Hask :+:  Hask
        |Hask :*:  Hask
        |HVar Name
        |HLam Name Hask
        |Hask :$: Hask
        |HLet Name Hask Hask
        deriving (Read, Show)
        
infix 4 :==:
infixl 6 :+:
infixl 7 :*:
infixl 9 :$:

type  HEnv  =  [(Name, Value)]

showV :: Value -> String
showV (VBool b)   =  show b
showV (VInt i)    =  show i
showV (VFun _)    =  "<function>"
showV (VError)    =  "<error>"

eqV :: Value -> Value -> Bool
eqV (VBool b) (VBool c)    =  b == c
eqV (VInt i) (VInt j)      =  i == j
eqV (VFun _) (VFun _)      =  error "Unknown"
eqV (VError ) (VError)      =  error "Unknown"
eqV _ _               = False

hEval :: Hask -> HEnv -> Value
hEval HTrue r         =  VBool True
hEval HFalse r        =  VBool False

hEval (HIf c d e) r   =
  hif (hEval c r) (hEval d r) (hEval e r)
  where  hif (VBool b) v w  =  if b then v else w
         --hif _ _ _ = VError   
         hif x _ _ = error ("Nu am primit a conditie valabila\nAm primit : \""++(showV x)++"\"")
  
hEval (HLit i) r      =  VInt i

hEval (d :==: e) r     =  heq (hEval d r) (hEval e r)
  where  heq (VInt i) (VInt j) = VBool (i == j)
         heq x y = error ("Nu am primit valori valabile\nAm primit : \""++(showV x)++"\", \""++(showV y)++"\"")
         -- heq  _ _ = VError    
  
hEval (d :+: e) r    =  hadd (hEval d r) (hEval e r)
  where  hadd (VInt i) (VInt j) = VInt (i + j)
         hadd x y = error ("Nu am primit valori valabile\nAm primit : \""++(showV x)++"\", \""++(showV y)++"\"")
         -- hadd _ _  = VError   

hEval (d :*: e) r    =  hmult (hEval d r) (hEval e r)
  where  hmult (VInt i) (VInt j) = VInt (i * j)
         hmult x y = error ("Nu am primit valori valabile\nAm primit : \""++(showV x)++"\", \""++(showV y)++"\"")
         -- hmult _ _  = VError   
  
hEval (HVar x) r      =  fromMaybe VError (lookup  x r)

hEval (HLam x e) r    =  VFun (\v -> hEval e ((x,v):r))


hEval (d :$: e) r    =  happ (hEval d r) (hEval e r)
  where  happ (VFun f) v  =  f v
         happ x y = error ("Nu am primit valori valabile\nAm primit : \""++(showV x)++"\", \""++(showV y)++"\"")
         -- happ _ _ = VError

hEval (HLet x ex e) r =  hEval e ((x, (hEval ex r)):r)

run :: Hask -> String
run pg = showV (hEval pg [])

h0 =  (HLam "x" (HLam "y" ((HVar "x") :+: (HVar "y")))) 
      :$: (HLit 3)
      :$: (HLit 4)

h1 =  (HLam "z" (HLam "x" (HLam "y" ((HVar "z") :+: (HVar "x") :*: (HVar "y")))))
      :$: (HLit 4)
      :$: (HLit 5)
      :$: (HLit 6)
      


test_h0 = eqV (hEval h0 []) (VInt 7)
test_h1 = eqV (hEval h1 []) (VInt 34)

testErrIF = run (HIf (HLit 1) (HLit 2) (HLit 3))
testErrEQ = run ((HLit 2) :==: (HVar "x"))
testErrAdd = run ((HLit 2) :+: (HVar "x"))
testErrMult = run ((HLit 2) :*: (HVar "x"))
testErrEval = run ((HLit 2) :$: (HVar "x"))

h2 =  HLet "x" (HLit 3) ((HLit 4) :+: HVar "x")
test_h2 = eqV (hEval h2 []) (VInt 7)
