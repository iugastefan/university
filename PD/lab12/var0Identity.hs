
--- Monada Identity

newtype Identity a = Identity { runIdentity :: a }

instance Monad Identity where
    return a = Identity a
    ma >>= k = k (runIdentity ma)

instance Applicative Identity where
    pure = return
    mf <*> ma = do
      f <- mf
      a <- ma
      return (f a)

instance Functor Identity where
   fmap f ma = pure f <*> ma

type M a = Identity a
-- Limbajul si  Interpretorul
showM :: Show a => M a -> String
showM = show . runIdentity

type Name = String

data Term = Var Name
          | Con Integer
          | Term :+: Term
          | Lam Name Term
          | App Term Term
  deriving (Show)

pgm :: Term
pgm = App
  (Lam "y"
    (App
      (App
        (Lam "f"
          (Lam "y"
            (App (Var "f") (Var "y"))
          )
        )
        (Lam "x"
          (Var "x" :+: Var "y")
        )
      )
      (Con 3)
    )
  )
  (Con 4)


data Value = Num Integer
           | Fun (Value -> M Value)
           | Wrong

instance Show Value where
 show (Num x) = show x
 show (Fun _) = "<function>"
 show Wrong   = "<wrong>"

type Environment = [(Name, Value)]

interp :: Term -> Environment -> M Value
interp = undefined


--test :: Term -> String
--test t = showM $ interp t []

pgm1:: Term
pgm1 = App
          (Lam "x" ((Var "x") :+: (Var "x")))
          ((Con 10) :+:  (Con 11))
-- test pgm
-- test pgm1
