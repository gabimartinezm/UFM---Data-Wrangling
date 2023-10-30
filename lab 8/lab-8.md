Lab 8
================
Gabriela Martinez
2023-10-29

\#Laboratorio 8 - Missing Data

## Parte 1

Antes de comenzar a completar el missing data primero hay que ver con
que se esta trabajando y que columnas son las que se va a trabajar el
missing data

``` r
#ver que columnas tienen NAs
names(which(colSums(is.na(data)) > 0))
```

    ## [1] "Age"      "SibSp"    "Parch"    "Fare"     "Embarked"

``` r
names(which(colSums(is.na(data)) == 0))
```

    ## [1] "PassengerId" "Survived"    "Pclass"      "Name"        "Sex"        
    ## [6] "Ticket"      "Cabin"

``` r
head(data, 15)
```

    ## # A tibble: 15 × 12
    ##    PassengerId Survived Pclass Name   Sex     Age SibSp Parch Ticket  Fare Cabin
    ##          <dbl>    <dbl>  <dbl> <chr>  <chr> <dbl> <dbl> <dbl> <chr>  <dbl> <chr>
    ##  1           2        1      1 Cumin… ?        38     1     0 PC 17…  71.3 C85  
    ##  2           4        1      1 Futre… fema…    35     1     0 113803  53.1 C123 
    ##  3           7        0      1 McCar… male     54     0     0 17463   51.9 E46  
    ##  4          11        1      3 Sands… fema…    NA     1    NA PP 95…  16.7 G6   
    ##  5          12        1      1 Bonne… fema…    58    NA     0 113783  26.6 C103 
    ##  6          22        1      2 Beesl… male     34     0     0 248698  13   D56  
    ##  7          24        1      1 Slope… ?        NA     0     0 113788  35.5 A6   
    ##  8          28        0      1 Fortu… ?        19     3     2 19950  263   C23 …
    ##  9          53        1      1 Harpe… fema…    49     1    NA PC 17…  76.7 D33  
    ## 10          55        0      1 Ostby… male     65     0     1 113509  62.0 B30  
    ## 11          63        0      1 Harri… male     45     1     0 36973   83.5 C83  
    ## 12          67        1      2 Nye, … fema…    29     0     0 C.A. …  10.5 F33  
    ## 13          76        0      3 Moen,… male     25     0     0 348123  NA   F G73
    ## 14          89        1      1 Fortu… fema…    NA     3     2 19950  263   C23 …
    ## 15          93        0      1 Chaff… ?        46    NA     0 W.E.P…  61.2 E31  
    ## # ℹ 1 more variable: Embarked <chr>

Se econtró que las columnas que tienen NAs son las de: “age”, “SibSp”,
“Parch”, “Fare” y “Embarked”.

Además se encontró que en la columna de “Sex” se tiene un símbolo de
interrogación “?” en algunos registros por lo que estos también seran
considerados commo NAs.

Las columnas de “PassengerId”, “Survived”, “Pclass”, “Name”, Ticket” y
“Cabin” tienen sus datos completos.

Primero se crean las funciones para cada tipo de imputación:

``` r
#funciones para inputar missing data 

#imputación general -----------------------------

#imputacion de media

imputacion_media <- function(columna, data) {
  media_col <- data %>%
    filter(!is.na({{columna}})) %>%
    summarise(media_col = round(mean({{columna}}, na.rm = TRUE))) %>%
    pull(media_col)
  
  print(media_col)
  
  data <<- data %>%
    mutate({{columna}} := ifelse(is.na({{columna}}), media_col, {{columna}}))
  
  return(data)

}

#imputación de mediana

imputacion_mediana <- function(columna, data) {
  mediana_col <- data %>%
    filter(!is.na({{columna}})) %>%
    summarise(mediana_col = round(median({{columna}}, na.rm = TRUE))) %>%
    pull(mediana_col)
  
  print(mediana_col)
  
  data <<- data %>%
    mutate({{columna}} := ifelse(is.na({{columna}}), mediana_col, {{columna}}))
  
  return(data)

}

#imputacion de moda

imputacion_moda <- function(columna, data) {
  moda_col <- data %>%
    filter(!is.na({{columna}})) %>%
    summarise(moda_col = round(Mode({{columna}}, na.rm = TRUE))) %>%
    pull(moda_col)
  
  print(moda_col)
  
  data <<- data %>%
    mutate({{columna}} := ifelse(is.na({{columna}}), moda_col, {{columna}}))
  
  return(data)

}

#imputacion por medio de outliers ---------
#Standard deviation approach 
imputacion_outliers <- function(columna, data) {
  lower_p <- data %>%
    filter(!is.na({{columna}})) %>%
    summarise(lower_p = round(quantile({{columna}}, na.rm = TRUE, probs = 0.10))) %>%
    pull(lower_p)
  
  upper_p <- data %>%
    filter(!is.na({{columna}})) %>%
    summarise(upper_p = round(quantile({{columna}}, na.rm = TRUE, probs = 0.90))) %>%
    pull(upper_p)
  
  data <<- data %>%
    mutate({{columna}} := ifelse({{columna}} < lower_p | is.na({{columna}}), lower_p, {{columna}}),
           {{columna}} := ifelse({{columna}} > upper_p, upper_p, {{columna}}))
}
```

Luego se corren las funciones creadas segun cada metodo para su
dataframe correspondiente, tomando en cuenta que estas solo se correran
sobre las columnas numericas, por lo que “Embarked” y “Sex” no serán
afectadas

``` r
#media 
imputacion_media(Age, data)
imputacion_media(SibSp, data)
imputacion_media(Parch, data)
imputacion_media(Fare, data)

data_media <- data

#mediana 
data <- read_csv("titanic_MD.csv")

imputacion_mediana(Age, data)
imputacion_mediana(SibSp, data)
imputacion_mediana(Parch, data)
imputacion_mediana(Fare, data)

data_mediana <- data

#moda
data <- read_csv("titanic_MD.csv")

imputacion_moda(Age, data)
imputacion_moda(SibSp, data)
imputacion_moda(Parch, data)
imputacion_moda(Fare, data)

data_moda <- data

#regresion lineal
data <- read_csv("titanic_MD.csv")


#Age ---------
data_filtered <- data[!is.na(data$Age), ]

modelo_age <- lm(formula = Age ~ Survived + Pclass, data = data_filtered)

data <- data %>% 
   mutate(Age = ifelse(is.na(Age), predict(modelo_age, newdata = data.frame(Survived = Survived, Pclass = Pclass), interval = "prediction"), Age))

#SibSp ---------
data_filtered <- data[!is.na(data$SibSp), ]

modelo_age <- lm(formula = SibSp ~ Survived + Pclass, data = data_filtered)

data <- data %>% 
   mutate(SibSp = ifelse(is.na(SibSp), predict(modelo_age, newdata = data.frame(Survived = Survived, Pclass = Pclass), interval = "prediction"), SibSp))

data_regresion <- data

#Parch ---------
data_filtered <- data[!is.na(data$Parch), ]

modelo_age <- lm(formula = Parch ~ Survived + Pclass, data = data_filtered)

data <- data %>% 
   mutate(Parch = ifelse(is.na(Parch), predict(modelo_age, newdata = data.frame(Survived = Survived, Pclass = Pclass), interval = "prediction"), Parch))

#Fare ---------
data_filtered <- data[!is.na(data$Fare), ]

modelo_age <- lm(formula = Fare ~ Survived + Pclass, data = data_filtered)

data <- data %>% 
   mutate(Fare = ifelse(is.na(Fare), predict(modelo_age, newdata = data.frame(Survived = Survived, Pclass = Pclass), interval = "prediction"), Fare))

data_regresion <- data

#outliers
data <- read_csv("titanic_MD.csv")

imputacion_outliers(Age, data)
imputacion_outliers(SibSp, data)
imputacion_outliers(Parch, data)
imputacion_outliers(Fare, data)

data_ouliers <- data
```

Ahora se compara con la data correcta:

``` r
data_correcta <- read_csv("titanic.csv")
```

    ## Rows: 183 Columns: 12
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (5): Name, Sex, Ticket, Cabin, Embarked
    ## dbl (7): PassengerId, Survived, Pclass, Age, SibSp, Parch, Fare
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
metricas_data <- data_correcta %>% 
  summarise(edad_promedio = mean(Age),
         fare_promedio = mean(Fare),
         edad_mediana = median(Age),
         fare_mediano = median(Fare),
         edad_moda = Mode(Age),
         fare_moda = Mode(Fare))
```

Sinceramente creo que ninguno se acerca mucho a la realidad por la
variedad de personas que estaban a bordo del barco. Si se tuviera más
información para poder entrenar un modelo de regresión lineal y ver que
variables afectan más a las otras variables y si se debería incluir
alguna variación de alguna variable (como el cuadrado de una variable o
el logaritmo o exponencial, etc) se cree que este se podría acercar más
a esta realidad.

Los unicos que si se apegan a la mayoria son para media, mediana y moda
de las categorias de Parch y SibSp pero porque como se trabaja con
muchos 0 no se logra sacar una medida muy acertada por lo que coloca un
0 y le logra acertar a varios datos. pero en el caso de “Age” y “Fare”
no hay ninguno que logre llenar los registros de manera satisfactoria,
ya que no son muy acertados.

## Parte 2

``` r
#se utilizara la tabla de data_media 

#estandarizacion ----------------------
estandarizacion <- function(columna, data_media){
  data_media <- data_media %>% 
    mutate(media = mean({{columna}}),
           desv = sd({{columna}}),
           {{columna}} := ({{columna}} - media)/ desv) %>% 
    select(-c(media, desv))
  
  data_media <<- data_media
  
  return(data_media)
}

#min max scaling ---------------
minmaxscale <- function(columna, data_media){
  data_media <- data_media %>% 
    mutate(minimo = min({{columna}}),
           maximo = max({{columna}}),
           {{columna}} := ({{columna}} - minimo)/ (maximo - minimo)) %>% 
    select(-c(minimo, maximo))
  
  data_media <<- data_media
  
  return(data_media)
}


#maxAbsScaler
maxAbsScaler <- function(columna, data_media){
  data_media <- data_media %>% 
    mutate(max_abs = max(abs({{columna}})),
           {{columna}} := {{columna}}/max_abs) %>% 
    select(-c(max_abs))
  
  data_media <<- data_media
  
  return(data_media)
}

estandarizacion(Age, data_media)
minmaxscale(Fare, data_media)
maxAbsScaler(SibSp, data_media)
estandarizacion(Parch, data_media)

#data correcta normalizada 
data_correcta <- estandarizacion(Age, data_media = data_correcta)
data_correcta <- minmaxscale(Fare, data_media = data_correcta)
data_correcta <- maxAbsScaler(SibSp, data_media = data_correcta)
data_correcta <- estandarizacion(Parch, data_media = data_correcta)
```

En general ambos la data correcta y la data de media si quedan con
valores similares, pero no son datos que se acercan a los datos de la
vida real o incluso datos que tengan sentido. Investigando más se
encontró que no siempre es necesario el normalizar los datos, en
especial cuando se trabajan con caracteristicas binarias o “escalas
naturales” que son aquellas escalas las cuales tienen sentido para el
problema que se esta trabajando sin tener que manipularlas.

En el caso de este problema como se ven atributos como la edad, el
precio de un ticket e incluso si se tiene hermanos, parejas o papás
todas estas pueden ser consideradas escalas naturales, ya que
naturalmente nos dicen lo que signfica y el sentido que tienen sin
necesidad de normalizarlas y su diferencia entre registros también
muestra una relación o indicación lógica.

Por lo que se puede concluir que esta base de datos no necesitaba ser
normalizada.
