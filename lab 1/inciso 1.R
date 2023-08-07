library(readxl)
library(readr)
library(writexl)
library(dplyr)
 

archivos <- c("01-2018.xlsx", "02-2018.xlsx","03-2018.xlsx","04-2018.xlsx",
           "05-2018.xlsx", "06-2018.xlsx", "07-2018.xlsx", "08-2018.xlsx",
          "09-2018.xlsx","10-2018.xlsx", "11-2018.xlsx")

#cargar las tablas 
leerdatos <-  function(x){
  datos <- read_excel(x)
  datos <- select(datos, COD_VIAJE, CLIENTE, UBICACION,
                  CANTIDAD, PILOTO, Q, CREDITO, UNIDAD)
  month <- substr(x, 1, 2)
  year <- substr(x, 4, 7)
  datos$Fecha <- paste0(month, "-", year)
  return(datos)
}

data <- lapply(archivos, leerdatos)
datacompleta <- bind_rows(data)

write_xlsx(datacompleta, path = "data_completa.xlsx")




