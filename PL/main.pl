mananca(X):-are_mancare(X).
mananca_impreuna(X,Y):- mananca(X), mananca(Y),\+ X=Y.
are_mancare(stefan).
are_mancare(iulia).
are_mancare(mihai).
are_mancare(eu).
