function lab1_1()
  e = 1e-5;
  f = @(x) x.^3 - 7*x.^2 + 14*x - 6;
  x1 = MetBisectie(f,0,1,e);
  x2 = MetBisectie(f,1,3.2,e);
  x3 = MetBisectie(f,3.2,4,e);
  X=linspace(0,4,100);
  Y=f(X);
  hold on
  plot(X,Y,'LineWidth',2);
  plot(x1,f(x1),'o','MarkerFaceColor','g','MarkerSize',10)
  plot(x2,f(x2),'o','MarkerFaceColor','g','MarkerSize',10)
  plot(x3,f(x3),'o','MarkerFaceColor','g','MarkerSize',10)
  xlabel('ox')
  ylabel('oy')
  title('Metoda bisectie')
  hold off
end