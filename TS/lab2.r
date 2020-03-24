#1 integrala de la 0 la 1 din (1-x^2)^(19/2)
n <- 10 ^ 6
U <- runif(n)
g <- function(x)
{
  (1 - x ^ 2) ^ (19 / 2)
}

gU <- g(U)
suma <- sum(gU) / n

int <- integrate(g, 0, 1)




#2 integrala de la -2 la 2 din e(x+x^2)


g <- function(x)
{
  exp(x + x ^ 2)
}

n <- 10 ^ 6
a <- -2
b <- 2
U <- runif(n, a, b)
gU <- g(U)
f <- 1 / (b - a)
suma <-  sum(gU) / n / f

int <- integrate(g, a, b)


#3 integrala de la 0 la inf din x*((1+x^2)^(-2)) = 0 la 1 din x*((1+x^2)^(-2)) + de la 1 la inf din x*((1+x^2)^(-2))
# schimbare de variabila x = 1/t in integrala de la 1 la inf


g <- function(x)
{
  x * (1 + x ^ 2) ^ (-2) + (1 / x ^ 2) * (1 / x) * (1 + (1 / x) ^ 2) ^ (-2)
}

n <- 10 ^ 6
a <- 0
b <- 1
U <- runif(n, a, b)
gU <- g(U)
suma <-  sum(gU) / n

int <- integrate(g, a, b)


#4 int -inf la inf din exp((-1)* x^2) tema
g <- function(x)
{
  2 * exp((-x) / (1 - x)) - (1 / (1 - x) ^ 2)
}

n <- 10 ^ 6
a <- 0
b <- 1
U <- runif(n, a, b)
gU <- g(U)
suma <-  sum(gU) / n

int <- integrate(g, a, b)


#5 int de la 0 la 1 din int de la 0 la 1 din exp((x+y)^2)

g <- function(x,y)
{
  exp((x+y)^2)
}

n <- 10 ^ 6
a <- 0
b <- 1
U <- runif(n, a, b)
U2 <- runif(n, a, b)
gU <- g(U,U2)
suma <-  sum(gU) / n

int <- integrate(g, a, b)

#6 TEMA: int de la 0 la inf din int de la 0 la x din exp((-1)*(x+y))