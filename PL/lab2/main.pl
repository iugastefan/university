distance((X, Y), (A, B), W) :- W is sqrt((A-X)**2+(B-Y)**2).
fib(0,1).
fib(1,1).
fib(X,Y) :- X>1, fib(1,1,2,X,Y).
fib(X,Y,Z,Z,W) :- W is X+Y.
fib(X,Y,Z1,Z2,W) :- P is X+Y, P2 is Z1+1, fib(Y,P,P2,Z2,W).

scrie(1, Y) :- write(Y).
scrie(X, Y) :- X>1, write(Y), Z is X-1, scrie(Z,Y).
 
square(X, Y) :- square(X,X,Y).
square(1,X,Y) :- scrie(X, Y),nl.
square(Z,X,Y) :- Z>1, scrie(X,Y),nl, W is Z-1, square(W,X,Y).

concat([], List, List).
concat([E| List1], List2, [E|List3]) :- concat(List1,List2,List3).
a.
all_a([E|List]) :- length(List,X), X>1, member(E,List), all_a(List).
all_a([E|List]) :- [X|List], E =:= X.