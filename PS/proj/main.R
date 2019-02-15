data(trees) ## access the data from R’s datasets package
head(trees) ## primele cateva date
str(trees) ## structura datelor
library("GGally")
library("scatterplot3d")


## folosim ggpairs din GGally pentru a vedea corelarea dintre variabile si construirea de 'density plots'
ggpairs(data=trees, columns=1:3, title="trees data") 
## observam ca volumul este corelat strans de circumferinta: 0.967
## intuim si o corelare intre inaltime si volum, dar coeficientul este mai mic

## Regresia simpla

reg_1  <- lm(Volume ~ Girth, data = trees) 
## lm deseneaza o linie (linear model) astfel incat suma distantelor dintre linie si puncte ridicate la patrat sa fie cat mai mica

summary(reg_1)
## summary ne da detalii despre modelul creat
## folosim aceste detalii pentru a ne da seama daca exista vreo relatie intre variabile, si daca da, cat de potrivit este modeulul

## Coefficients:
## intercept: -36.94, Girth: 5.06 => volume = -36.94 + 5.06 * girth
## p-value < 2e-16 *** este important sa fie mai mic ca 0.05 si sa aibe cat mai multe '*'
## p-value determina daca exista vreo relatie intre variabile
## t-value = 20.38 trebuie sa fie cat mai mare
## t-value determina daca coeficientul nu este 0 doar din intamplare
## Pr(>|t|) trebuie sa fie cat mai mic
## Pr determina daca coeficientii au insemnatate

## F-Statistic: 419.4 trebuie sa fie cat mai mare
## Std. Error: 0.2474 trebuie sa fie cat mai apropiata de 0
## Adj R-squared: 0.9331 trebuie sa fie cat mai mare
## R-squared: 0.9353 trebuie sa fie cat mai mare >0.7
aic <- AIC(reg_1)
bic <- BIC(reg_1)
## AIC si BIC trebuie sa fie cat mai mici

## Considerand rezultatele, modelul se dovedeste bun si potrivit

## Folosim ggplot pentru a creea o histograma
ggplot(data = trees, aes(x = Girth, y = Volume)) + geom_point()  +
  stat_smooth(method = "lm", col = "magenta") +
  theme(panel.background = element_rect(fill = "white"),
        axis.line.x=element_line(),
        axis.line.y=element_line())

## Folosim date ce nu se gasesc in datele initiale pentru a testa modelul
## Girth: 18.2 Height: 72 Volume:46.2
predict(reg_1, data.frame(Girth = 18.2))
## volumul rezultat este 55.2, apropiat de 46.2
## intuim ca am putea imbunatati rezultatul construind o regresie multipla


## Prima regresie multipla

## introducem inaltimea ca variabila
## modelul acesta are ca variabile fata de volum, circumferinta si inaltimea, independente una fata de cealalta
reg_2 <- lm(Volume ~ Girth + Height, data = trees)
summary(reg_2)
## Observam ca modelul se potrivestem iar Adj. R-squared este chiar mai mare decat cel initial

## Pentru a putea vizualiza, folosim un model 3D

Girth <- seq(9,21, by=0.5)
Height <- seq(60,90, by=0.5)
grid <- expand.grid(Girth = Girth, Height = Height)
grid$Volume2 <-predict(reg_2, new = grid)
reg_2_viz <- scatterplot3d(grid$Girth, grid$Height, grid$Volume2, angle = 65, color = "magenta", pch = 1, 
                          ylab = "Hight", xlab = "Girth", zlab = "Volume" )
reg_2_viz$points3d(trees$Girth, trees$Height, trees$Volume, pch=16)

predict(reg_2, data.frame(Girth = 18.2, Height = 72))
## noul volum este 52.12, mai apropiat de 46.2 decat valoarea initiala 55.2



## A doua regresie multipla

## considerand faptul ca inaltimea si circumferinta unui copac sunt legate una de cealalta (copacii inalti tind sa fie mai grosi)
## construim un model ce are ca variabile fata de volum, circumferinta si inaltimea, dar de data asta dependente una fata de cealalta, simbolizata prin '*'
reg_3<- lm(Volume ~ Girth * Height, data = trees)
summary(reg_3)

## observam ca Adj R-squared este si mai mare randul acesta, F-statistic este destul de mare, iar p-value este la fel de mic
Girth <- seq(9,21, by=0.5)
Height <- seq(60,90, by=0.5)
grid <- expand.grid(Girth = Girth, Height = Height)
grid$Volume3 <-predict(reg_3, new = grid)
reg_3_viz <- scatterplot3d(grid$Girth, grid$Height, grid$Volume3, angle = 65, color = "magenta", pch = 1,
                           ylab = "Hight", xlab = "Girth", zlab = "Volume")
reg_3_viz$points3d(trees$Girth, trees$Height, trees$Volume, pch=16)

predict(reg_3, data.frame(Girth = 18.2, Height = 72))
## noul volum este 45.881, mult mai apropiat de 46.2, data de primele predictii