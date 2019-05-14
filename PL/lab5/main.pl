afisHelp(0).
afisHelp(X):- X>0, X1 is (X-1), write('*'),afisHelp(X1).
afisHelp2(0).
afisHelp2(X):- X>0, X1 is (X-1), afisHelp(X), write('\n'), afisHelp2(X1).
afis(X):-afisHelp2(X).
afis1(X,Y):-Y is (X*(X+1)/2),afis(X),!.
