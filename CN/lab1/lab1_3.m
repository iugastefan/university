function lab1_3()
  f = @(x) x.^3 - 7*x.^2 + 14*x - 6; 
  df = @(x) 3*x.^2 - 14*x + 14;
  hold on
  plotiuga(f,0,4);
  eps = 1e-5;
  x0=0.5;
  x1=2.2;
  x2=3.5;
  xaprox0 = MetNR(f,df,x0,eps);
  xaprox1 = MetNR(f,df,x1,eps);
  xaprox2 = MetNR(f,df,x2,eps);
  plot(xaprox0,f(xaprox0),'o','MarkerFaceColor','g','MarkerSize',10);
  plot(xaprox1,f(xaprox1),'o','MarkerFaceColor','g','MarkerSize',10);
  plot(xaprox2,f(xaprox2),'o','MarkerFaceColor','g','MarkerSize',10);
  hold off
end