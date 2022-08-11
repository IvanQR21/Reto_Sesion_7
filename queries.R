install.packages("DBI")
install.packages("RMySQL")
install.packages("dplyr")

library(DBI)
library(RMySQL)

# Una vez que se tengan las librerias necesarias se procede a la lectura 
# (podr? ser que necesites otras, si te las solicita instalalas y cargalas). 
# De la base de datos de Shiny, la cual es un demo y nos permite interactuar con 
# este tipo de objetos. El comando dbConnect es el indicado para realizar la 
# lectura, los dem?s par?metros son los que nos dan acceso a la BDD.

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Si no se arrojaron errores por parte de R, vamos a explorar la BDD

dbListTables(MyDataBase)

# Desplegar los campos o variables que contiene la tabla 
# City

dbListFields(MyDataBase, 'City')

# Consulta tipo MySQL

DataDB <- dbGetQuery(MyDataBase, "select * from City")

# El Objeto DataDB es un data frame pertenece a R
# y podemos aplicar los comandos usuales

class(DataDB)
head(DataDB)


pop.mean <- mean(DataDB$Population)  # Media a la variable de poblaci?n
pop.mean 

pop.3 <- pop.mean *3   # Operaciones aritmeticas
pop.3

# Incluso podemos hacer usos de otros comandos de busqueda aplicando la 
# libreria dplyr

library(dplyr)
pop50.mex <-  DataDB %>% filter(CountryCode == "MEX" ,  Population > 50000)   # Ciudades del país de México con más de 50,000 habitantes

head(pop50.mex)

unique(DataDB$CountryCode)   # Paises que contiene la BDD

# Nos desconectamos de la base de datos
dbDisconnect(MyDataBase)
