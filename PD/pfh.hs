

data Alegere 
    = Piatra 
    | Foarfeca 
    | Hartie
  deriving (Eq, Show)

data Rezultat 
    = Victorie
    | Infrangere
    | Egalitate
  deriving (Show, Eq)

partida :: Alegere -> Alegere -> Rezultat

partida x y 
    = case (x,y) of
        (Piatra,Foarfeca) -> Victorie
        (Piatra,Hartie) -> Infrangere
        (Piatra,Piatra) -> Egalitate
        (Foarfeca,Hartie) -> Victorie
        (Foarfeca,Piatra) -> Infrangere
        (Foarfeca,Foarfeca) -> Egalitate
        (Hartie, Piatra) -> Victorie
        (Hartie ,Foarfeca) -> Infrangere
        (Hartie, Hartie) -> Egalitate