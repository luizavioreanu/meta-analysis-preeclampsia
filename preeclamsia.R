library(meta)
library(metacom)
library(metafor)

###############################

### EXAMPLE: preemclamsia   ###

###############################


#data entry

study <- c("Weseley et al. 1962", "Flowers et al. 1962", "Menzies 1964", "Fallis et al. 1964", "Cuadros et al. 1964", "Landesman et al. 1965", "Kraus et al. 1966", "Tervila et al. 1971", "Campbell et al. 1975")
e.T <- c(14,21,14,6,12,138,15,6,65) # cases in treatment arm
n.T <- c(131,385,57,38,1011,1370,506,108,153)#totals in treatment arm
e.C <- c(14,17,24,18,35,175,20,2,40) #cases in control arm
n.C <- c(136,134,48,40,760,1336,524,103,102) #totals in control arm
p.T <- (e.T+.5)/(n.T+1)
p.C <- (e.C+.5)/(n.C+1)

preeclampsia <- data.frame(study, e.T, n.T, p.T, e.C, n.C, p.C)


# how to solve it:
length(study)

#Create analysis object

a <- metabin(event.e = e.T,
             n.e = n.T,
             event.c = e.C,
             n.c = n.C,
             studlab = study,
             data = preeclampsia,
             sm = "OR",         # choosen effect: odds ratio
             method = "MH")     # choosen method:Mantel-Haenszel 
summary(a)


forest(a)
#qq plot
qqnorm(a$TE/a$seTE)
qqline(a$TE/a$seTE)

# verification bias methods:
#1
x<-metabias(a,method="rank",k.min=9)
x
#2
y<-metabias(a,method="peters",k.min=9)
y
#3
tf1<-trimfill(a)
tf1
