crosswd(V1,V2,V3,H1,H2,H3):-	word(V1,_,X1,_,X4,_,X7,_),
				word(V2,_,X2,_,X5,_,X8,_),
				word(V3,_,X3,_,X6,_,X9,_),
				word(H1,_,X1,_,X2,_,X3,_),
				word(H2,_,X4,_,X5,_,X6,_),
				word(H3,_,X7,_,X8,_,X9,_).

born(jan, date(20,3,1977)).
born(jeroen, date(2,2,1992)).
born(joris, date(17,3,1995)).
born(jelle, date(1,1,2004)).
born(joan, date(24,12,0)).
born(joop, date(30,4,1989)).
born(jannecke, date(17,3,1993)).
born(jaap, date(16,11,1995)).

year(Y,Name) :- born(Name, date(_,_,Y)).
before(date(X1,Y1,Z1), date(X2,Y2,Z3)) :- Z1 < Z3; Z1==Z3, Y1<Y2; Z1==Z3, Y1==Y2, X1<X2.
older(X, Y) :- born(X, W), born(Y, Z), before(W, Z).

path(X, Y) :- connected(X, Y).
path(X, Y) :- connected(X, Z), path(Z, Y).

successor([], [x]).
successor([X|Rest], [X|Rest2]):-successor(Rest,Rest2).

plus([],Y,Y).
plus([X|Rest], Y, [X|Rest2]):-plus(Rest,Y,Rest2).

times([x], W, W).
times([_|Rest], Y, X):-times(Rest,Y,X2), plus(X2,Y,X).

element_at([X|_], 1, X).
element_at([_|X], Y, Z):- Y1 is (Y-1), element_at(X,Y1,Z).

animal(alligator). 
animal(tortue) .
animal(caribou).
animal(ours) .
animal(cheval) .
animal(vache) .
animal(lapin) .

mutant(X):- 	animal(Y), 
		animal(Z), 
		Y\==Z, 
		name(Y,Yn), 
		name(Z,Zn), 
		append(Y1,Y2,Yn), 
		Y1 \== [],
		append(Y2,_,Zn), 
		Y2 \==[], 
		append(Y1,Zn,W),
		name(X,W).