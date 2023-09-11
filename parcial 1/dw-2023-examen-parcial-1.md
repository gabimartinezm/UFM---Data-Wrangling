dw-2023-parcial-1
================
Tepi
9/11/2023

# Examen parcial

Indicaciones generales:

- Usted tiene el período de la clase para resolver el examen parcial.

- La entrega del parcial, al igual que las tareas, es por medio de su
  cuenta de github, pegando el link en el portal de MiU.

- Pueden hacer uso del material del curso e internet (stackoverflow,
  etc.). Sin embargo, si encontramos algún indicio de copia, se anulará
  el exámen para los estudiantes involucrados. Por lo tanto, aconsejamos
  no compartir las agregaciones que generen.

## Sección 0: Preguntas de temas vistos en clase (20pts)

- Responda las siguientes preguntas de temas que fueron tocados en
  clase.

1.  ¿Qué es una ufunc y por qué debemos de utilizarlas cuando
    programamos trabajando datos?

ufunc es una función universal que permite hacer una operación en cada
elemento individual del array. Se debe utilizar al trabajar con datos ya
que permite hacer un código más eficiente y hacer operaciones
complicadas en una lista de objetos

2.  Es una técnica en programación numérica que amplía los objetos que
    son de menor dimensión para que sean compatibles con los de mayor
    dimensión. Describa cuál es la técnica y de un breve ejemplo en R.

hacer un broadcasting sobre una matriz, donde las funciones se aplican
de manera vectorizada sobre arrays o listas de diferentes tamaños

3.  ¿Qué es el axioma de elegibilidad y por qué es útil al momento de
    hacer análisis de datos?

el axioma de elegibilidad mantien que para cada familia de conjuntos no
vacios existe otro conjunto que tiene un elemento de cada una de estas
familias. Es útil, ya que permite manejar muestras y definir funciones
en ámbitos más abstractos a la hora de trabajar con datos más complejos

4.  Cuál es la relación entre la granularidad y la agregación de datos?
    Mencione un breve ejemplo. Luego, exploque cuál es la granularidad o
    agregación requerida para poder generar un reporte como el
    siguiente:

| Pais | Usuarios |
|------|----------|
| US   | 1,934    |
| UK   | 2,133    |
| DE   | 1,234    |
| FR   | 4,332    |
| ROW  | 943      |

Granularidad hace referencia al nivel de detalle en un conjunto de
datos, mientras que la agregación es el proceso por el cual se reduce
esta granularidad.

Para poder generar un reporte como el anterior se necesita un registro
de cada usuario donde se tenga la información de este donde este
incluido su país. La agregación necesaria sería la agrupación por países
de los registos y el conteo de cada uno.

## Sección I: Preguntas teóricas. (50pts)

- Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
  deberá responder 5. Las 5 a responder estarán determinadas por un
  muestreo aleatorio basado en su número de carné.

- Ingrese su número de carné en `set.seed()` y corra el chunk de R para
  determinar cuáles preguntas debe responder.

``` r
set.seed("20210219")
v<- 1:10
preguntas <-sort(sample(v, size = 5, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 1, 2, 3, 4, 7"

``` r
#preguntas a responder 1, 2, 3, 4, 7
```

### Listado de preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:

    - `str()`
    - `df[,c("a","b")]`
    - `names(df)[4] <- "new_name"` donde la posición 4 corresponde a la
      variable `old_name`
    - `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?

    - El nuevo elemento
    - `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?

    - SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
      \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

## Sección II Preguntas prácticas. (30pts)

- Conteste las siguientes preguntas utilizando sus conocimientos de R.
  Adjunte el código que utilizó para llegar a sus conclusiones en un
  chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

``` r
library(readr)
library(dplyr)
library(tidyverse)
library(knitr)

df <- readRDS("parcial_anonimo.rds")

head(df)
```

    ##         DATE Codigo Material Descripcion     Pais Distribuidor Territorio
    ## 1 2018-12-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 2 2018-11-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 3 2018-10-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 4 2018-09-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 5 2018-08-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 6 2018-07-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ##    Cliente    Marca Canal Venta Unidades plaza  Venta
    ## 1 9d6e1d65 61d7fbfc    7b48292e              2  26.50
    ## 2 9d6e1d65 61d7fbfc    7b48292e              0   0.00
    ## 3 9d6e1d65 61d7fbfc    7b48292e              3  39.75
    ## 4 9d6e1d65 61d7fbfc    7b48292e              3  39.75
    ## 5 9d6e1d65 61d7fbfc    7b48292e              8 106.00
    ## 6 9d6e1d65 61d7fbfc    7b48292e              3  39.75

``` r
#ver en que paises esta cada cliente
paises <-
  df %>%
  distinct(Pais)

clientes <-
  df %>%
  distinct(Cliente)

clientes_x_pais <-
  df %>%
  select(Cliente, Pais, Venta) %>%
  group_by(Cliente, Pais) %>%
  count() %>%
  pivot_wider(names_from = Pais, values_from = n)

names(clientes_x_pais)[2:3] <- c("pais1","pais2")

clientes_dospaises <-
  clientes_x_pais %>%
  filter(pais1 >= 1) %>%
  filter(pais2 >= 1)

ventas_por_cliente <-
  df %>%
  select(Cliente, Venta) %>%
  group_by(Cliente) %>%
  summarise(ventas_totales = sum(Venta))


cliente_mas_rentable <-
  inner_join(clientes_dospaises, ventas_por_cliente)
```

    ## Joining with `by = join_by(Cliente)`

``` r
#pregunta 2------------------------------------------------------------------

territorios <-
  df %>%
  distinct(Territorio)

ventas_por_territorio <-
  df %>%
  select(Territorio, Venta) %>%
  group_by(Territorio) %>%
  summarise(ventas_totales = sum(Venta),
            cantidad_de_ventas = n())

ventas_por_territorio_negativas <-
  df %>%
  select(Territorio, Venta) %>%
  filter(Venta <= 0) %>%
  group_by(Territorio) %>%
  summarise(perdidas_totales = sum(Venta),
            ventas_negativas = n())

ventas_territorios_negativos <- inner_join(ventas_por_territorio_negativas, ventas_por_territorio)
```

    ## Joining with `by = join_by(Territorio)`

``` r
ventas_territorios_negativos <-
  ventas_territorios_negativos %>%
  mutate(proporcion_v_negativas = ventas_negativas/cantidad_de_ventas)

kable(cliente_mas_rentable)
```

| Cliente  | pais1 | pais2 | ventas_totales |
|:---------|------:|------:|---------------:|
| 044118d4 |   297 |   371 |        9436.24 |
| a17a7558 |   589 |   289 |       19817.70 |
| bf1e94e9 |   751 |  1237 |           0.00 |
| c53868a0 |   289 |   431 |       13812.87 |
| f2aab44e |    42 |     3 |         400.39 |
| f676043b |   237 |    50 |        3634.75 |
| ff122c3f |   187 |   512 |       15358.54 |

El cliente más rentable que se encuentrá en más de un país es “a17a7558”
ya que este es el que genera más ventas de los clientes que se
encuentran en dos países

Según lo observado, los siguientes territorios generán pérdida en una
proporción mayor al 45% de sus ventas, por lo que se debería de
considerar ya no operar alli

``` r
kable(ventas_territorios_negativos)
```

| Territorio | perdidas_totales | ventas_negativas | ventas_totales | cantidad_de_ventas | proporcion_v\_negativas |
|:-----------|-----------------:|-----------------:|---------------:|-------------------:|------------------------:|
| 002da6aa   |          -101.82 |              501 |       47206.24 |                977 |               0.5127943 |
| 0320288f   |           -33.56 |               66 |         845.40 |                106 |               0.6226415 |
| 0bbe6418   |          -217.97 |              319 |        8891.86 |                564 |               0.5656028 |
| 0bfe69a0   |            -5.56 |               39 |         384.34 |                 66 |               0.5909091 |
| 0c169a3b   |         -1171.35 |             1857 |      117192.85 |               3277 |               0.5666768 |
| 0dd30fcd   |          -479.00 |              974 |       43825.07 |               2041 |               0.4772171 |
| 0ef0ce97   |          -348.30 |             1499 |       58741.91 |               2778 |               0.5395968 |
| 0f915ffc   |           -14.35 |              237 |        3260.09 |                417 |               0.5683453 |
| 11676773   |           -27.14 |              379 |       12753.74 |                734 |               0.5163488 |
| 13b223c9   |             0.00 |                4 |          49.94 |                  6 |               0.6666667 |
| 14c263f1   |           -66.31 |              555 |       12868.09 |                919 |               0.6039173 |
| 1a9b2b4c   |           -45.28 |              173 |        6437.24 |                294 |               0.5884354 |
| 1c81fb6c   |          -480.80 |             1264 |      156006.01 |               2145 |               0.5892774 |
| 1d407777   |         -3299.56 |             3873 |      204600.97 |               8111 |               0.4774997 |
| 1e107bf6   |             0.00 |              101 |        2311.07 |                185 |               0.5459459 |
| 1fac8d59   |             0.00 |               56 |        1181.67 |                 88 |               0.6363636 |
| 23e9d55d   |          -764.86 |             2661 |      239481.12 |               4588 |               0.5799913 |
| 28559553   |           -82.28 |              229 |       11848.89 |                383 |               0.5979112 |
| 2e4c5a7c   |           -91.50 |             1129 |       92032.27 |               1826 |               0.6182913 |
| 2e812869   |         -3056.10 |             4174 |      138779.92 |               8436 |               0.4947843 |
| 3153c73e   |          -221.30 |              259 |        9573.60 |                427 |               0.6065574 |
| 3350838e   |           -75.92 |              550 |       15336.98 |               1012 |               0.5434783 |
| 368301e2   |             0.00 |               13 |         121.47 |                 20 |               0.6500000 |
| 3cae948b   |          -625.63 |             1970 |       88957.73 |               3459 |               0.5695288 |
| 3e0d75d0   |             0.00 |               22 |         646.66 |                 38 |               0.5789474 |
| 4163fa3f   |             0.00 |               38 |         579.63 |                 65 |               0.5846154 |
| 456278b8   |             0.00 |               45 |         492.51 |                 74 |               0.6081081 |
| 45c0376d   |          -475.30 |              667 |       10645.98 |               1167 |               0.5715510 |
| 4814799f   |          -664.33 |              882 |       24263.20 |               1726 |               0.5110081 |
| 4856cd94   |          -637.73 |              734 |       41176.56 |               1305 |               0.5624521 |
| 4ca9988b   |          -757.63 |             2581 |      109103.42 |               4911 |               0.5255549 |
| 4f860572   |           -40.73 |              224 |        5263.41 |                404 |               0.5544554 |
| 54969a29   |          -192.45 |              406 |       18611.11 |                703 |               0.5775249 |
| 55f0e537   |             0.00 |              133 |        5854.46 |                229 |               0.5807860 |
| 5a464f3f   |          -126.23 |              190 |        4794.98 |                299 |               0.6354515 |
| 5d43dd39   |             0.00 |              331 |        6479.03 |                565 |               0.5858407 |
| 5dbdab07   |             0.00 |              288 |       16871.11 |                511 |               0.5636008 |
| 64e2147f   |             0.00 |               74 |         964.15 |                138 |               0.5362319 |
| 67696f68   |          -253.92 |              484 |       47176.17 |                748 |               0.6470588 |
| 67a61c29   |           -63.23 |              167 |        4605.40 |                275 |               0.6072727 |
| 67e9cc18   |         -2720.84 |             3763 |      126770.82 |               7255 |               0.5186768 |
| 680cec1c   |          -388.97 |             1508 |       86902.02 |               2838 |               0.5313601 |
| 6837187c   |          -137.46 |              256 |        7775.28 |                454 |               0.5638767 |
| 6899442b   |          -138.58 |              251 |        9449.56 |                411 |               0.6107056 |
| 68de9759   |          -225.72 |              147 |        3704.48 |                247 |               0.5951417 |
| 69c1b705   |         -3370.11 |             3743 |      152545.17 |               7282 |               0.5140071 |
| 6c8335a4   |           -39.92 |              201 |        3594.25 |                357 |               0.5630252 |
| 6eff1266   |          -176.04 |              193 |        7439.71 |                321 |               0.6012461 |
| 72520ba2   |         -3760.95 |             3869 |      356377.19 |               6732 |               0.5747178 |
| 75298f79   |         -1568.37 |             1362 |       73568.31 |               2310 |               0.5896104 |
| 77192d63   |         -5640.55 |             6602 |      247252.00 |              13335 |               0.4950881 |
| 79428560   |             0.00 |                5 |         132.00 |                  9 |               0.5555556 |
| 7a27b27e   |           -89.63 |              217 |       12187.71 |                415 |               0.5228916 |
| 7a861731   |          -791.87 |             2953 |      155217.06 |               5573 |               0.5298762 |
| 7b674f31   |          -282.86 |              890 |       29449.97 |               1566 |               0.5683269 |
| 80d1e625   |          -232.32 |              855 |       26508.63 |               1654 |               0.5169287 |
| 81062400   |             0.00 |               79 |        1240.19 |                138 |               0.5724638 |
| 8682908b   |          -245.05 |              166 |        4611.76 |                279 |               0.5949821 |
| 8f79b7f8   |         -1858.11 |             1640 |      114890.36 |               3112 |               0.5269923 |
| 9043b930   |          -187.51 |              583 |       48448.12 |               1023 |               0.5698925 |
| 90e89bb4   |             0.00 |              149 |        2706.37 |                270 |               0.5518519 |
| 91e7e31b   |          -248.55 |             1276 |       53930.53 |               2350 |               0.5429787 |
| 9b45ae60   |             0.00 |               39 |         908.19 |                 67 |               0.5820896 |
| 9d9f2da6   |          -117.13 |              266 |       29283.36 |                538 |               0.4944238 |
| 9de43341   |           -13.78 |              210 |        3095.15 |                351 |               0.5982906 |
| 9fdcc550   |          -662.80 |             1051 |       46193.52 |               2175 |               0.4832184 |
| a0d39798   |         -1779.45 |             1054 |      441721.73 |               2131 |               0.4946035 |
| a7291d87   |          -286.21 |              588 |       88472.93 |                994 |               0.5915493 |
| a7ee3287   |          -295.40 |             1175 |       30228.41 |               2167 |               0.5422243 |
| a9e783db   |         -1188.62 |             1919 |       69900.88 |               3778 |               0.5079407 |
| abfa1d4e   |          -739.54 |             1274 |       43716.65 |               2648 |               0.4811178 |
| aed8e579   |             0.00 |               39 |         747.14 |                 73 |               0.5342466 |
| b20448cf   |          -138.21 |              653 |       12952.34 |               1169 |               0.5585971 |
| b50e91fb   |         -1523.34 |             2920 |      133056.91 |               6204 |               0.4706641 |
| b53a9360   |           -18.90 |              264 |        8073.55 |                490 |               0.5387755 |
| b77669c5   |          -231.18 |              690 |       51447.59 |               1329 |               0.5191874 |
| b97335a1   |         -1138.95 |             2117 |       59474.63 |               3834 |               0.5521648 |
| bc8e06ed   |         -3268.58 |             5534 |      329852.92 |              11362 |               0.4870621 |
| bcdf2ef9   |          -369.00 |              771 |       93740.07 |               1579 |               0.4882837 |
| bf1e94e9   |           -64.95 |             2270 |        9990.02 |               2495 |               0.9098196 |
| c072f75a   |           -35.32 |              215 |        6216.26 |                376 |               0.5718085 |
| c09056e6   |             0.00 |               48 |         957.63 |                 79 |               0.6075949 |
| c300284d   |           -20.87 |              149 |        4006.95 |                258 |               0.5775194 |
| c31adb2f   |          -230.43 |              293 |        9883.16 |                544 |               0.5386029 |
| c57e6d42   |         -1184.57 |             3536 |      179711.37 |               6203 |               0.5700468 |
| cc471eed   |           -48.02 |              114 |        3341.56 |                198 |               0.5757576 |
| cf970512   |             0.00 |              139 |        6375.19 |                274 |               0.5072993 |
| d02bf225   |             0.00 |               97 |        1315.21 |                167 |               0.5808383 |
| d43e8f6a   |          -136.20 |              257 |        5711.19 |                490 |               0.5244898 |
| d7254672   |          -117.13 |              266 |       29283.36 |                538 |               0.4944238 |
| d741afb6   |             0.00 |               74 |        1216.10 |                158 |               0.4683544 |
| d9eeaaad   |             0.00 |               73 |      125633.68 |                119 |               0.6134454 |
| dfd48934   |          -250.69 |              870 |       23317.90 |               1533 |               0.5675147 |
| e034e3c8   |             0.00 |               28 |         247.16 |                 52 |               0.5384615 |
| e49916a2   |          -674.32 |             1360 |      108294.54 |               2692 |               0.5052006 |
| e6fd9da9   |             0.00 |                8 |          18.16 |                 12 |               0.6666667 |
| ee3eb62b   |           -70.59 |              819 |       16420.59 |               1469 |               0.5575221 |
| f7dfc635   |        -14985.02 |            19054 |      916785.71 |              40247 |               0.4734266 |
| f871212f   |             0.00 |              325 |        5463.81 |                516 |               0.6298450 |
| f8e2b63c   |             0.00 |              176 |        6297.55 |                295 |               0.5966102 |
| f97a3f33   |          -180.44 |              438 |       17406.55 |                882 |               0.4965986 |
| f9c36cff   |          -128.64 |              920 |       68707.28 |               1723 |               0.5339524 |
| fce0345f   |          -111.07 |              457 |        7460.33 |                771 |               0.5927367 |
| fed6647d   |         -1433.40 |             5707 |      194384.06 |               9308 |               0.6131285 |

------------------------------------------------------------------------

### I. Preguntas teóricas

## 1. Para las siguientes sentencias de `base R`, liste su contraparte de `dplyr`

    * `str()`
    * `df[,c("a","b")]`
    * `names(df)[4] <- "new_name"` donde la posición 4 corresponde a la variable `old_name`
    * `df[df$variable == "valor",]`

respuesta

- `str()` en dplyr es igual a `glimpse()`
- `df[,c("a","b")]` en dplyr es igual a `select(df, a, b)`
- `names(df)[4] <- "new_name"` en dplyr es igual a
  `rename(df, new_name = 'old_name')`
- `df[df$variable == "valor",]` en dplyr es igual a
  `df %>% select(variable) %>% filter(variable == "valor")`

------------------------------------------------------------------------

## 2. Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas funciones que el keyword `OR` para filtrar uno o más elementos una misma columna?

respuesta

WHERE columna IN (elementos)

------------------------------------------------------------------------

## 3. ¿Por qué en R utilizamos funciones de la familia apply (lapply,vapply) en lugar de utilizar ciclos?

respuesta

porque es una manera más efciente de correr una misma función en una
lista de datos ya que permite correr multiples operaciones en un comando
y correrlo por todos los items de una lista con menos lineas de código
que un ciclo

------------------------------------------------------------------------

## 4. ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

respuesta

`==` es un operador lógico, por lo que se utiliza para hacer una
comparación. En cambio, `=` se utiliza para asignar un valor a una
variable

------------------------------------------------------------------------

## 7. ¿Qué pasa si quiero agregar una nueva categoría a un factor que no se encuentra en los niveles existentes?

respuesta

lo colocará como NA
