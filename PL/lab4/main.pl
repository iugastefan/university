la_dreapta(X,Y,[Y,X,_,_,_]).
la_dreapta(X,Y,[_,Y,X,_,_]).
la_dreapta(X,Y,[_,_,Y,X,_]).
la_dreapta(X,Y,[_,_,_,Y,X]).
la_stanga(X,Y,[X,Y,_,_,_]).
la_stanga(X,Y,[_,X,Y,_,_]).
la_stanga(X,Y,[_,_,X,Y,_]).
la_stanga(X,Y,[_,_,_,X,Y]).
langa(X,Y,Z):-la_dreapta(X,Y,Z);la_stanga(X,Y,Z).
solutie(Strada, PosesorZebra) :-
Strada = [
	casa(1,_,_,_,_,_),
	casa(2,_,_,_,_,_),
	casa(3,_,_,_,_,_),
	casa(4,_,_,_,_,_),
	casa(5,_,_,_,_,_)],
	member(casa(_,englez,rosie,_,_,_),Strada),
	member(casa(_,spaniol,_,caine,_,_), Strada),
	member(casa(_,_,verde,_,cafea,_),Strada),
	member(casa(_,ucrainian,_,_,ceai,_),Strada),
	la_dreapta(casa(_,_,verde,_,_,_),casa(_,_,bej,_,_,_),Strada),
	member(casa(_,_,_,melci,_,oldgold),Strada),
	member(casa(_,_,galben,_,_,kools),Strada),
	member(casa(3,_,_,_,lapte,_),Strada),
	member(casa(1,norvegian,_,_,_,_),Strada),
	langa(casa(_,_,_,_,_,chesterfields),casa(_,_,_,vulpe,_,_),Strada),
	langa(casa(_,_,_,_,_,kools),casa(_,_,_,cal,_,_),Strada),
	member(casa(_,_,_,_,sucport,luckystrike),Strada),
	member(casa(_,japonez,_,_,_,parliaments),Strada),
	langa(casa(_,norvegian,_,_,_,_),casa(_,_,albastru,_,_,_),Strada),
	member(casa(_,PosesorZebra,_,zebra,_,_),Strada).

include('words.pl').

word_letters(X,Y) :- atom_chars(X,Y).

nr_aparitii(X,Y,Z):- occurrences_of_term(X,Y,Z).

cover([],_).
cover([X|Z],Y) :- nr_aparitii(X,[X|Z],W), nr_aparitii(X,Y,W2), W=<W2, cover(Z,Y).

solution(X,Y,Z) :-  word(Y), word_letters(Y,W), length(W,W2),W2 =:= Z,cover(W,X),!.

topsolution(X,Y):- length(X,Z), topsolution(X,Y,Z).
topsolution(_,nimic,0).
topsolution(X,Y,Z) :- solution(X,Y,Z),!.
topsolution(X,Y,Z) :-Z1 is Z-1, topsolution(X,Y,Z1).
