function lab1_2()
  y1 = @(x) exp(x) - 2;
  y2 = @(x) cos(exp(x)-2);
  X = linspace(0.5,1.5,100);
  Y1 = y1(X);
  Y2 = y2(X);
  eps = 1e-5;
  f = @(x) exp(x) - 2 - cos(exp(x)-2);
  xaprox = MetBisectie(f,0.5,1.5,eps);
  hold on
  %plot(X,Y1);
  plotiuga(y1,0.5,1.5);
  plot(X,Y2);
  plot(xaprox,f(xaprox),'o','MarkerFaceColor','g','MarkerSize',10);
  hold off
end