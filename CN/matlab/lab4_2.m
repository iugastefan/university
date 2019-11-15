function lab4_2()
A=[0 -3 -6 4; -1 -2 -1 3; -2 -3 0 3; 1 4 5 -9];
A2=[2 -2 0 0; 2 1 0 0; -4 4 0 0; 4 -1 (10^-20) (10^-20)];
tol = 0.1;
tol2 = 10^-20;
tol3 = 10^-10;
x=Rang(A,tol)
x2=Rang(A,tol2)
x3=Rang(A,tol3)

x4=Rang(A2,tol)
x5=Rang(A2,tol2)
x6=Rang(A2,tol3)
end