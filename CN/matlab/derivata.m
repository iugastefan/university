function [df] = derivata(f)
  pkg load symbolic
  syms x;
  df=function_handle(diff(f(x),x))
end
