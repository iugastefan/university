n <- 1000000
#U <- runif(n, -2, 2)
U <- runif(n,0,1)
g <- function(x)
{
  #(1 - x ^ 2) ^ (7 / 2)
  #exp(x+x^2)
  x*(1+x^2)^(-2)+(1/x^2)*(1/x)*(1+(1/x)^2)^(-2)
}

gU <- g(U)
# suma <- 4* sum(gU) / n 
suma <- sum(gU) / n 
int <- integrate(g,0,1)

# int de la 0 la inf din x*(1+x^2)^(-2) TEMA -> 0 la 1 (1/x^2)*(1/x)*(1+(1/x)^2)^(-2)
