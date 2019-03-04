male(rickardStark).
male(eddardStark).
male(brandonStark).
male(benjenStark).
male(robbStark).
male(aerysTargaryen).
male(rhaegarTargaryen).
male(viserysTargaryen).
male(jonSnow).
female(lyarraStark).
female(catelynStark).
female(lyannaStark).
female(sansaStark).
female(aryaStark).
female(rhaellaTargaryen).
female(eliaTargaryen).
female(daenerysTargaryen).
female(rhaenysTargaryen).
parent_of(rickardStark, eddardStark).
parent_of(rickardStark, brandonStark).
parent_of(rickardStark, benjenStark).
parent_of(rickardStark, lyannaStark).
parent_of(lyarraStark, eddardStark).
parent_of(lyarraStark, brandonStark).
parent_of(lyarraStark, benjenStark).
parent_of(lyarraStark, lyannaStark).
parent_of(eddardStark, robbStark).
parent_of(eddardStark, sansaStark).
parent_of(eddardStark, aryaStark).
parent_of(eddardStark, branStark).
parent_of(eddardStark, rickonStark).
parent_of(catelynStark, robbStark).
parent_of(catelynStark, sansaStark).
parent_of(catelynStark, aryaStark).
parent_of(catelynStark, branStark).
parent_of(catelynStark, rickonStark).
parent_of(aerysTargaryen, rhaegarTargaryen).
parent_of(aerysTargaryen, eliaTargaryen).
parent_of(aerysTargaryen, viserysTargaryen).
parent_of(aerysTargaryen, daennerysTargaryen).
parent_of(rhaellaTargaryen, rhaegarTargaryen).
parent_of(rhaellaTargaryen, eliaTargaryen).
parent_of(rhaellaTargaryen, viserysTargaryen).
parent_of(rhaellaTargaryen, daenerysTargaryen).
parent_of(lyannaStark, jonSnow).
parent_of(rhaegarTargaryen, jonSnow).
parent_of(rhaegarTargaryen, rhaenysTargaryen).
parent_of(rhaegarTargaryen, aegonTargaryen).
parent_of(eliaTargaryen, rhaenysTargaryen).
parent_of(eliaTargaryen, aegonTargaryen).
father_of(X, Y) :- parent_of(X, Y), male(X).
mother_of(X, Y) :- parent_of(X, Y), female(X).
grandfather_of(X, Y) :- father_of(X, Z), parent_of(Z, Y).
grandmother_of(X, Y) :- mother_of(X, Z), parent_of(Z, Y).
grandparent_of(X, Y) :- parent_of(X, Z), parent_of(Z, Y).
sister_of(X, Y) :- parent_of(Z, X), parent_of(Z, Y), female(X).
brother_of(X, Y) :- parent_of(Z, X), parent_of(Z, Y), male(X).
aunt_of(X, Y) :- grandparent_of(Z, Y), parent_of(Z, X), female(X).
uncle_of(X, Y) :- grandparent_of(Z, Y), parent_of(Z, X), male(X).
ancestor_of(X, Y) :- parent_of(X, Y).
ancestor_of(X, Y) :- parent_of(X, Z), ancestor_of(Z, Y).
not_parent(X, Y) :- (male(X);female(X)), (\+ parent_of(X, Y)), \+X=Y.