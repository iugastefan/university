function lab4_1()
A = [0 1 -2;1 -1 1;1 0 -1];
b = [4;6;2];
Aext = [A b];
r = Rang(A,1e-10);
rext = Rang(Aext,1e-10);
verificareRang(A,r,rext);


A2 = [1 -2 3;-2 3 -4;3 -4 5];
b2 = [4;-5;6];
A2ext = [A2 b2];
r2 = Rang(A2,1e-10);
r2ext = Rang(A2ext,1e-10);
verificareRang(A2,r2,r2ext);

A3 = [0 1 1;2 1 5;4 2 1];
b3 = [3;5;1];
A3ext = [A3 b3];
r3 = Rang(A3,1e-10);
r3ext = Rang(A3ext,1e-10);
verificareRang(A3,r3,r3ext);
end