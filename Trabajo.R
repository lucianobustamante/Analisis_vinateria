#title: "An�lisis vinater�a"
#author: "Bustamante Luciano Emanuel"

# introducci�n
#Se tomo una empresa ficticia de vinater�a, se compra vinos a productores locales y se vende a larga escala en el mercado.
#Uno de los problemas que se encuentra, es que los vinos no se estan vendiendo y no estan generando satisfacci�n al cliente, realizo este an�lisis para saber cual es un punto fuerte de la venta del mismo.

#cargo las librerias
library(readr)
library(ggthemes)
library(ggplot2)
library(DataExplorer)
library(corrplot)
library(proto)
library(gsubfn)
library(sqldf)
library(RSQLite)

# cargo mi dataset
vinos_tintos <- read_csv("facultad/vinos_tintos.csv")
head(vinos_tintos)

#conozco el formato de mi base de datos, encontrando que la mayoria son numericos y algunos son objetos/nombres
str(vinos_tintos)

# quiero saber que cuantos paises se encuentran dentro de mis datos, vemos anomalias
graficobarras <- ggplot( data = vinos_tintos,
                         mapping = aes(x= factor(country))) +
  geom_bar()
graficobarras

#observo que los datos estan mal ordenados, voy a unir espana y spagna con spain usando un bucle
for ( i in 1:length(vinos_tintos$country)) {
  if (vinos_tintos$country[i] == 'Espana' || vinos_tintos$country[i] == 'Spagna') {
    vinos_tintos$country[i] = 'Spain'
  } 
}

#vuelvo a graficar ya con los datos acomodados
graficobarras <- ggplot( data = vinos_tintos,
                         mapping = aes(x= factor(country))) +
  geom_bar()
graficobarras

attach(vinos_tintos)
#histograma de todos los componentes
plot_histogram(vinos_tintos)

#grafico de barras de los precios
graficobarrasprecio <- ggplot( data = vinos_tintos,
                               mapping = aes(x= factor(pricing))) +
  geom_bar()
graficobarrasprecio

# quiero saber cual es el procentaje de valores faltantes 
plot_missing(vinos_tintos)

#elimino los datos faltantes
vinos_tintos <- na.omit(vinos_tintos)

#boxplot de alcohol y success
#la mayoria en promedio esta cerca del 60% de alcohol
boxplot(success)
boxplot(alcohol)

# grafico de regresi�n y dispersi�n 
ggplot( data = vinos_tintos) + 
  aes(x = alcohol, y = success) +
  geom_point() +
  geom_smooth( method = 'lm', col = 'red')


## Conclusi�n:

#-Podemos deducir, con nuestro an�lisis, que uno de los factores determinantes en el precio y exito es el alcohol, ya que tiene un gran tendencia a crecer.Por lo tanto, mas alcohol, mejor seran mis ventas.
