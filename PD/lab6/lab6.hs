import Data.Char
import Data.List.Split
prelStr strin = map toUpper strin
ioString = do
           strin <- getLine
           putStrLn $ "Intrare\n" ++ strin
           let strout = prelStr strin
           putStrLn $ "Iesire\n" ++ strout

prelNo noin = sqrt noin
ioNumber = do
           noin <- readLn :: IO Double
           putStrLn $ "Intrare\n" ++ (show noin)
           let noout = prelNo noin
           putStrLn $ "Iesire"
           print noout

inoutFile = do
            sin <- readFile "Input.txt"
            putStrLn $ "Intrare\n" ++ sin
            let sout = prelStr sin
            putStrLn $ "Iesire\n" ++ sout
            writeFile "Output.txt" sout

data Persoana = Persoana { nume :: String
                         , varsta :: Int
                         } deriving (Show,Eq)
instance Ord Persoana where
     compare (Persoana nume1 varsta1) (Persoana nume2 varsta2) =
             compare varsta1 varsta2

ceiMaiMari :: [Persoana] -> [Persoana]
ceiMaiMari xs = filter (\x -> x >= (maximum xs)) xs

citesteWhile :: Int -> [Persoana] -> IO()
citesteWhile 0 xs = putStrLn $ "Cei mai mari: " ++ 
                    (concat(map (\(Persoana nume varsta)->nume++" ("++(show varsta)++" ani) ") (ceiMaiMari xs)))
citesteWhile x xs = do
                  nume <- getLine
                  varsta <- readLn :: IO Int
                  citesteWhile (x-1) ((Persoana nume varsta):xs)
ex1 :: IO()
ex1 = do
      nr <- readLn :: IO Int
      citesteWhile nr []

ex2 = do
      sin <- readFile "ex2.in"
      let xs = lines sin
      let persoane = map (\x -> splitOn ", " x ) xs
      rs <- sequence (map print (map (\(Persoana nume varsta)->nume++" ("++(show varsta)++" ani) ")(ceiMaiMari(map (\[x,y]->(Persoana x (read y::Int)))persoane))))
      print rs
