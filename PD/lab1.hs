import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x+x


triple :: Integer -> Integer
triple x = x+x+x

maxim :: Integer -> Integer -> Integer
maxim x y = if (x > y)
               then x
               else y

max3 x y z = 
    let 
        u = maxim x y
    in 
        maxim  u z

maxim4 x y z w =
    let
        u = maxim x y
        q = maxim u z
    in
        maxim q w

max4test x y z w =
    let
        i = maxim4 x y z w
    in
        i>=x&&i>=y&&i>=z&&i>=w

               
