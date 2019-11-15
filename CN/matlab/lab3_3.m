function lab3_3()
A1=[0 1 1;2 1 5;4 2 1];
b1=[3;5;1];
A2=[0 1 -2;1 -1 1;1 0 -1];
b2=[4;6;2];
x1 = GaussFaraPivot(A1,b1)
x2 = GaussFaraPivot(A2,b2)
x3 = GaussPivPart(A1,b1)
x4 = GaussPivPart(A2,b2)
x5 = GaussPivTot(A1,b1)
x6 = GaussPivTot(A2,b2)

end