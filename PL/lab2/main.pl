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

all_a([a]).
all_a([X|List]) :- X = a, all_a(List).

trans_a_b([a],[b]).
trans_a_b([X|Lista],[Y|Listb]) :- X = a, Y = b, trans_a_b(Lista,Listb).

scalarMult(_,[],[]).
scalarMult(X,[Y|List],[Z|Lista2]) :-  Z is X*Y, scalarMult(X,List,Lista2).

dot([],[],0).
dot([X|Lista1],[Y|Lista2],R) :- dot(Lista1,Lista2,R1),  R is (X*Y + R1).

max([W],W).
max([Y|List],R) :- max(List, W), (Y>=W, R=Y;Y<W, R=W).

palindrome([]).
palindrome([_]).
palindrome(List) :- append([X|Tail],[X],List) , palindrome(Tail).

remove_duplicates([],[]).
remove_duplicates([X|List],Y) :- member(X,List), !,remove_duplicates(List,Y).
remove_duplicates([X|List],[X|Y]) :- remove_duplicates(List,Y).

invers(X,Y):-invers(X,Y,[]).
invers([],Y,Y).
invers([H|T],Y,Z):-invers(T,Y,[H|Z]).