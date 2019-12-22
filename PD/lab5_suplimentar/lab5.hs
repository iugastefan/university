-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/



import Data.Char
import Data.List


-- 1.
rotate :: Int -> [Char] -> [Char]
rotate x xs 
    | x<0  = (error "Numar negativ")
    | x> (length xs) = (error "Numar prea mare")
    | otherwise = (\(x,y)->y++x) (splitAt x xs)

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
                        where l = length str
                              m = if l == 0 then 0 else k `mod` l

-- 3. 
makeKey :: Int -> [(Char, Char)]
makeKey x = zip ['A'..'Z'] (rotate x ['A'..'Z'])

-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp x xs
    | null xs = x
    | fst (head xs) == x = snd (head xs)
    | otherwise = lookUp x (tail xs)

-- 5.
encipher :: Int -> Char -> Char
encipher x c = lookUp c (makeKey x)

-- 6.
normalize :: String -> String
normalize xs
    | null xs = xs
    | isAlpha h = (toUpper h): normalize t
    | isDigit h = h:normalize t
    | otherwise = normalize t
    where h = head xs
          t = tail xs

-- 7.
encipherStr :: Int -> String -> String
encipherStr x xs = map (encipher x) (normalize xs)

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey xs = map (\(x,y)->(y,x)) xs

-- 9.
decipher :: Int -> Char -> Char
decipher x c
    | c == ' ' = ' '
    | isDigit c = c
    | isUpper c = lookUp c (reverseKey (makeKey x))
    | otherwise = '\0'

decipherStr :: Int -> String -> String
decipherStr x xs
    | null xs = xs
    | c == '\0' = decipherStr x (tail xs)
    | otherwise = c:decipherStr x (tail xs)
    where c = decipher x (head xs)


-- 11.
contains :: String -> String -> Bool
contains x y
    | (null x) || (null y) = False
    | isPrefixOf y x = True
    | otherwise = contains (tail x) y

-- 12.
candidates :: String -> [(Int, String)]
candidates xs = filter (\(x,y) -> (contains y "THE")|| (contains y "AND")) [(x,(decipherStr x xs))|x<-[0..26]]

