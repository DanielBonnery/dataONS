library(dataONS)
data(parish110217popest)
head(parish110217popest[parish110217popest$year=="mid_2002",c("PAR11NM","Population")])