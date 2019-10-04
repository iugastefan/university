function xaprox = MetNR(f,df,x0,eps)
  k = 1;
  x(1) = x0;
  do
    k = k+1;
    x(k) = x(k-1) - f(x(k-1))/df(x(k-1));
  until abs(x(k)-x(k-1))/x(k-1) >= eps;
  xaprox = x(k);
end
