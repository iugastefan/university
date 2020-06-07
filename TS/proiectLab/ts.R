# Vom folosi paralelism pentru a calcula simularile in paralel
library(parallel)

# Clusterul primeste numarul de core-uri al masinii pe care ruleaza
cl <- makeCluster(detectCores())

# Evaluam variabilele si funtiile si le facem disponibile pentru cluster
clusterEvalQ(cl, {
  
  # Functie de repartitie pentru variabila aleatoare ce determina valoarea
  # fiecarei despagubiri
  F <- function(x) {
    if (x < 0)
      return (0)
    
    if (x < 1)
      return ((x ^ 2 + x) / 2)
    return (1)
  }
  
  # Rata procesului Poisson pentru cereri de despagubire
  lam <- 8 #/zi
  
  # Rata procesului Poisson pentru noi clienti
  nu <- 18 #/zi
  
  # Parametru pentru repartitia exponentiala ce determina timpul
  # pentru care clientii raman fideli firmei
  mu <- 0.2 #zile
  
  # Suma platita de clienti per unitate de timp
  c <- 2 #euro/zi
  
  # Durata de timp pe care se face analiza
  T <- 365 #zile
  
  # Capital de inceput
  a0 <- 50000 #euro
  
  # Numarul initial de clienti
  n0 <- 12 #clienti
  
  # Probabilitatea aparitiei unui client nou
  pClientNou <- function(nu, n, mu, lam) {
    return (nu / (nu + n * mu + n * lam))
  }
  
  # Probabilitatea pierderii unui client
  pPierdereClient <- function(nu, n, mu, lam) {
    return ((n * mu) / (nu + n * mu + n * lam))
  }
  
  # Probabilitatea cererii unei despagubiri
  pDespagubire  <- function(nu, n, mu, lam) {
    return ((n * lam) / (nu + n * mu + n * lam))
  }
  
  # X ~ Exp
  getXfromExp  <- function(l) {
    return (-log(runif(1),exp(1))/l)
  }
  
  # Definirea unei simulari primeste ca parametru a0 capital initial
  simulare <- function(a0) {
    # t = timp de pornire
    t <- 0 
    
    # a = capitalul
    a <- a0
    
    # n = nr de clienti
    n <- n0
    
    # X = peste cat timp va avea loc urmatorul eveniment
    X <- getXfromExp(nu + n * mu + n * lam)
    
    # tE = timpul urmatorului eveniment
    tE <- X
    
    repeat {
      # Daca timpul urmatorului eveniment depaseste marja de timp pentru 
      # care se face simularea (T) inseamna ca firma nu a dat faliment
      # in aceasta perioada de timp
      if (tE > T) {
        return(1)
      }
    
      # Adaugam la capital suma pe unitate de timp (c) * timpul de la ultimul
      # eveniment
      a <-  a + n * c * (tE - t)

      # t ia acum timpul evenimentului urmator
      t <- tE
      
      # Generam o variabila uniforma pentru a vedea ce
      # fel de eveniment are loc
      U <- runif(1)

      # Apare un client nou si incrementam nr de clienti (n) cu 1
      if (U < pClientNou(nu, n, mu, lam)) {
        n <- n + 1

      # Pierdem un client iar numarul de clienti (n) este decrementat
      } else if (U < (pClientNou(nu, n, mu, lam) +
		      pPierdereClient(nu, n, mu, lam))) {
        n <- n - 1

      # Are loc o cerere de despagubire
      } else {
	# Generam Y valoarea sumei de despagubire
        U1 <- runif(1)
        Y <- F(U1)

	# Daca suma depaseste capitalul actual, dam faliment
        if (Y > a) {
          return (0)

	# Altfel scadem Y din capital
        } else {
          a <- a - Y
        }
      }

      # Aflam timpul urmatorului eveniment
      X <- getXfromExp(nu + n * mu + n * lam)
      tE <- t + X
    }
  }
  
})

# Functie ce simuleaza un numar de simulari (nrSim) si calculeaza media lor
calcProcent <- function(a){
  a0 <- a
  nrSim <- 10
  i <- 1
  S <- 0
  while (i <= nrSim) {
    S <-  S + simulare(a0)
    i <- i + 1
  }
  pr <- S/nrSim
  result <- list("Capital"=a0,"Procent"= pr)
  return (result)
}

# Am observat din rulari anterioare ca suma minima pentru a nu da faliment
# se afla intre 40000 si 50000, astfel rulam in paralel simulari pentru
# toate sumele aflate intre aceste numere
rezultate <- parLapply(cl,seq(40000,50000,500),calcProcent)

# Oprim cluster-ul
stopCluster(cl)

# Probabilitatea de faliment cautata
proc <- 0.2
for(i in 1:length(rezultate)){
  if(rezultate[[i]]$Procent>=proc){
    print(rezultate[[i]])
    break
  }
}
